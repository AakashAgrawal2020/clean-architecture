import 'dart:async';
import 'dart:convert';

import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient implements NetworkServices {
  static final DioClient _singleton = DioClient._internal();
  late final Dio _dio;
  final int _maxRetryAttempts = 3;

  Timer? _debounceTimer;
  CancelToken? _activeCancelToken;

  DioClient._internal() {
    _dio = Dio(BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5)));
    _initializeInterceptors();
  }

  factory DioClient() {
    return _singleton;
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Requesting: ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response received from ${response.requestOptions.uri}');
        return handler.next(response);
      },
      onError: (DioException exception, handler) async {
        if (_shouldRetry(exception)) {
          await _retryRequest(exception, handler);
        } else {
          _handleException(exception);
          return handler.next(exception);
        }
      },
    ));
  }

  bool _shouldRetry(DioException exception) {
    return exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.receiveTimeout;
  }

  Future<void> _retryRequest(
      DioException exception, ErrorInterceptorHandler handler) async {
    final requestOptions = exception.requestOptions;
    int retryCount = requestOptions.extra['retryCount'] ?? 0;

    if (retryCount < _maxRetryAttempts) {
      requestOptions.extra['retryCount'] = retryCount + 1;
      try {
        final response = await _dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(e as DioException);
      }
    }
  }

  Future<dynamic> _requestWithOptionalDebounce(
      Future<Response<dynamic>> Function(CancelToken cancelToken) request,
      {bool useDebounce = true}) async {
    _activeCancelToken?.cancel();
    _debounceTimer?.cancel();
    if (!useDebounce) {
      return await _executeRequest(request, _activeCancelToken!);
    }

    _activeCancelToken = CancelToken();
    Completer<dynamic> completer = Completer();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final response = await request(_activeCancelToken!);
        completer.complete(jsonDecode(response.toString()));
      } on DioException catch (e) {
        completer.complete(
            e.response != null ? jsonDecode(e.response.toString()) : null);
      } catch (e) {
        debugPrint('Unexpected error: $e');
        completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<dynamic> _executeRequest(
      Future<Response<dynamic>> Function(CancelToken cancelToken) request,
      CancelToken cancelToken) async {
    try {
      final response = await request(cancelToken);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      return e.response != null ? jsonDecode(e.response.toString()) : null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }

  @override
  Future<dynamic> getAPI(String path, {bool useDebounce = true}) async {
    return await _requestWithOptionalDebounce(
        (cancelToken) => _dio.get(path, cancelToken: cancelToken),
        useDebounce: useDebounce);
  }

  @override
  Future<dynamic> postAPI(String path, dynamic data,
      {bool useDebounce = true}) async {
    return await _requestWithOptionalDebounce(
        (cancelToken) => _dio.post(path, data: data, cancelToken: cancelToken),
        useDebounce: useDebounce);
  }

  void _handleException(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout) {
      debugPrint('Connection timeout occurred');
    } else if (exception.type == DioExceptionType.receiveTimeout) {
      debugPrint('Receive timeout occurred');
    } else if (exception.response != null) {
      switch (exception.response?.statusCode) {
        case 400:
          debugPrint('Bad request: ${exception.response?.data}');
          break;
        case 401:
          debugPrint('Unauthorized: ${exception.response?.data}');
          break;
        case 403:
          debugPrint('Forbidden: ${exception.response?.data}');
          break;
        case 404:
          debugPrint('Not found: ${exception.response?.data}');
          break;
        case 500:
          debugPrint('Internal server error');
          break;
        default:
          debugPrint('Invalid status code: ${exception.response?.statusCode}');
      }
    } else {
      debugPrint('Unexpected error: ${exception.message}');
    }
  }
}
