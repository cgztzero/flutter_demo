import '../net/request_callback.dart';

abstract class IHttpClient {
  Future<dynamic> getRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException});

  Future<dynamic> postRequest(String url, {Map<String, dynamic>? params,
    OnDisconnect? onDisconnect,
    OnHttpCodeError? onHttpCodeError,
    OnRequestException? onRequestException});

  Future<dynamic> putRequest(String url, {Map<String, dynamic>? params,
    OnDisconnect? onDisconnect,
    OnHttpCodeError? onHttpCodeError,
    OnRequestException? onRequestException});

  Future<dynamic> patchRequest(String url, {Map<String, dynamic>? params,
    OnDisconnect? onDisconnect,
    OnHttpCodeError? onHttpCodeError,
    OnRequestException? onRequestException});

  Future<dynamic> deleteRequest(String url, {Map<String, dynamic>? params,
    OnDisconnect? onDisconnect,
    OnHttpCodeError? onHttpCodeError,
    OnRequestException? onRequestException});
}
