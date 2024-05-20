abstract class IHttpClientService {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, {dynamic data, dynamic options});
  Future<dynamic> put(String url, {dynamic data});
  Future<dynamic> patch(String url, {dynamic data});
  Future<dynamic> delete(String url);
}
