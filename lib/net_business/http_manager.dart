import '../net/request_callback.dart';
import 'http_client.dart';

class HttpManager extends IHttpClient {
  final IHttpClient _httpClient;
  static HttpManager? _instance;

  HttpManager(this._httpClient);

  static void init(IHttpClient _httpClient) {
    _instance = HttpManager(_httpClient);
  }

  static HttpManager getInstance() {
    return _instance!;
  }

  @override
  Future<dynamic> deleteRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _httpClient.deleteRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  @override
  Future<dynamic> getRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _httpClient.getRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  @override
  Future<dynamic> patchRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _httpClient.patchRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  @override
  Future<dynamic> postRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _httpClient.postRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  @override
  Future<dynamic> putRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _httpClient.putRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }
}
