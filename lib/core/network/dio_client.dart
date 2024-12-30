import 'dart:async';

import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:dio/dio.dart';

class DioClient implements NetworkServices {
  static final DioClient _singleton = DioClient._internal();
  late final Dio _dio;
  final int _maxRetryAttempts = 3;
  Timer? _debounceTimer;

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
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (await _isConnectedToInternet() == false) {
        return handler.reject(DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            error: 'No Internet Connection'));
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioException exception, handler) async {
      if (_shouldRetry(exception)) {
        await _retryRequest(exception, handler);
      } else {
        final mappedException = _mapException(exception);
        return handler.reject(mappedException);
      }
    }));
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      final response = await Dio().get(
        Urls.googleForConnectivityCheck,
        options: Options(
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2)),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
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

  DioException _mapException(DioException exception) {
    if (exception.type == DioExceptionType.connectionError) {
      return DioException(
          requestOptions: exception.requestOptions,
          type: DioExceptionType.connectionError,
          error: 'Unable to connect. Please check your internet connection.');
    }
    return exception;
  }

  Future<dynamic> _requestWithOptionalDebounce(
      Future<Response<dynamic>> Function(CancelToken cancelToken) request,
      {bool useDebounce = false}) async {
    final cancelToken = CancelToken();

    if (!useDebounce) {
      return await _executeRequest(request, cancelToken);
    }

    Completer<dynamic> completer = Completer();
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final response = await request(cancelToken);
        completer.complete(response.data);
      } on DioException catch (e) {
        completer.completeError(_mapException(e));
      } catch (e) {
        completer.completeError(Exception('Unexpected error'));
      }
    });

    return completer.future;
  }

  Future<dynamic> _executeRequest(
      Future<Response<dynamic>> Function(CancelToken) request,
      CancelToken cancelToken) async {
    try {
      final response = await request(cancelToken);
      return response.data;
    } on DioException catch (e) {
      throw _mapException(e);
    } catch (e) {
      throw Exception('Unexpected error');
    }
  }

  @override
  Future<dynamic> getAPI(
      {required String path,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool useDebounce = false}) async {
    return await _requestWithOptionalDebounce(
        (cancelToken) => _dio.get(path,
            options: Options(headers: headers),
            queryParameters: queryParams,
            cancelToken: cancelToken),
        useDebounce: useDebounce);
  }

  @override
  Future<dynamic> postAPI(
      {required String path,
      required dynamic data,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool useDebounce = false}) async {
    return await _requestWithOptionalDebounce(
        (cancelToken) => _dio.post(path,
            data: data,
            options: Options(headers: headers),
            queryParameters: queryParams,
            cancelToken: cancelToken),
        useDebounce: useDebounce);
  }
}
