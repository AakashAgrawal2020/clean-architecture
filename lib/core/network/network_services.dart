abstract class NetworkServices {
  Future<dynamic> getAPI(String url);

  Future<dynamic> postAPI(String path, dynamic data);
}
