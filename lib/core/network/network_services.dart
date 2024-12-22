abstract class NetworkServices {
  Future<dynamic> getAPI(String path, {bool useDebounce = false});

  Future<dynamic> postAPI(String path, dynamic data,
      {bool useDebounce = false});
}
