import 'package:dio/dio.dart';

import '../net/request_callback.dart';
import 'http_client.dart';
import '../net/dio_net_work.dart';

///Dio实现的请求类
class DioIHttpClientImpl extends IHttpClient {
  late DioHttpClient _client;

  DioIHttpClientImpl({Dio? dio, bool? isDebug = false}) {
    if (dio == null) {
      _client = DioHttpClient(_getDefaultDio(), isDebug!);
    } else {
      _client = DioHttpClient(dio, isDebug!);
    }
  }

  void setBaseUrl(String url) {
    _client.setBaseUrl(url);
  }

  Dio _getDefaultDio() {
    return DioConfigBuilder()
        .setBaseUrl('https://www.wanandroid.com/')
        .setConnectTimeout(20 * 1000)
        .setReceiveTimeout(20 * 1000)
        .build();
  }

  @override
  Future<dynamic> deleteRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) {
    return _client.deleteRequest(url,
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
    return _client.getRequest(url,
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
    return _client.patchRequest(url,
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
    return _client.postRequest(url,
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
    return _client.putRequest(url,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }
}
