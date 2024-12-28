abstract class NetworkServices {
  Future<dynamic> getAPI(
      {required String path,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool useDebounce = false});

  Future<dynamic> postAPI(
      {required String path,
      required dynamic data,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool useDebounce = false});
}
