import 'package:dio/dio.dart';
import 'package:flutter_base/net/request_callback.dart';

import 'error_exception_handler.dart';
import 'net_log_interceptors.dart';
import 'network_util.dart';

///dio base library
class DioHttpClient {
  static const String post = "post";
  static const String get = "get";
  static const String put = "put";
  static const String patch = "patch";
  static const String delete = "delete";

  final Dio _dio;
  final bool _isDebug;
  DioErrorExceptionHandler? _exceptionHandler;

  DioHttpClient(this._dio, this._isDebug) {
    if (_isDebug) {
      _dio.interceptors.add(NetLogInterceptors());
    }
  }

  DioHttpClient setBaseUrl(String url) {
    _dio.options.baseUrl = url;
    return this;
  }

  DioHttpClient setDioErrorExceptionHandler(DioErrorExceptionHandler? handler) {
    _exceptionHandler = handler;
    return this;
  }

  Future<dynamic> getRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    return request(url,
        method: get,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  Future<dynamic> postRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    return request(url,
        method: post,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  Future<dynamic> putRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    return request(url,
        method: put,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  Future<dynamic> patchRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    return request(url,
        method: patch,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  Future<dynamic> deleteRequest(String url,
      {Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    return request(url,
        method: delete,
        params: params,
        onDisconnect: onDisconnect,
        onHttpCodeError: onHttpCodeError,
        onRequestException: onRequestException);
  }

  Future<dynamic> request(String url,
      {String method = post,
      Map<String, dynamic>? params,
      OnDisconnect? onDisconnect,
      OnHttpCodeError? onHttpCodeError,
      OnRequestException? onRequestException}) async {
    bool isConnect = await NetworkUtil.isConnectedNetwork();
    if (!isConnect) {
      //断网
      if (onDisconnect != null) {
        onDisconnect();
      }
      return null;
    }

    try {
      Response<dynamic> response = await _acquireResponse(url, method, params);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        //http请求错误
        if (_exceptionHandler != null) {
          if (_exceptionHandler!.onHandleHttpError(response)) {
            return null;
          }
        }
        if (onHttpCodeError != null) {
          onHttpCodeError(url: url, method: method, params: params, statusCode: response.statusCode);
        }
      }
    } on DioError catch (error) {
      if (_exceptionHandler != null) {
        if (_exceptionHandler!.onHandleDioError(error)) {
          //业务层统一拦截 此处不处理
          return null;
        }
      }
      rethrow;
    } on Exception catch (exception) {
      if (_exceptionHandler != null) {
        if (_exceptionHandler!.onHandleException(exception)) {
          return null;
        }
      }
      if (onRequestException != null) {
        onRequestException(url: url, method: method, params: params, exception: exception);
      }
    }

    return null;
  }

  Future<Response<dynamic>> _acquireResponse(String url, String method, Map<String, dynamic>? params) async {
    Response<dynamic>? response;
    switch (method) {
      case post:
        response = await _dio.post(url, data: params);
        break;
      case get:
        response = await _dio.get(url, queryParameters: params);
        break;
      case put:
        response = await _dio.put(url, data: params);
        break;
      case patch:
        response = await _dio.patch(url, data: params);
        break;
      case delete:
        response = await _dio.delete(url, data: params);
        break;
    }
    if (response == null) {
      response = Response<dynamic>(requestOptions: RequestOptions(path: url));
    }
    return response;
  }
}

class DioConfigBuilder {
  String baseUrl = '';
  int? connectTimeout, receiveTimeout;
  Map<String, String> headers = {};
  Interceptors interceptors = Interceptors();

  DioConfigBuilder setBaseUrl(String baseUrl) {
    this.baseUrl = baseUrl;
    return this;
  }

  DioConfigBuilder setConnectTimeout(int connectTimeout) {
    this.connectTimeout = connectTimeout;
    return this;
  }

  DioConfigBuilder setReceiveTimeout(int receiveTimeout) {
    this.receiveTimeout = receiveTimeout;
    return this;
  }

  DioConfigBuilder setHeaders(Map<String, String> headers) {
    this.headers.addAll(headers);
    return this;
  }

  DioConfigBuilder setHeader(String key, String value) {
    headers[key] = value;
    return this;
  }

  DioConfigBuilder setInterceptors(Interceptors interceptors) {
    this.interceptors.addAll(interceptors);
    return this;
  }

  DioConfigBuilder setInterceptor(InterceptorsWrapper interceptor) {
    interceptors.add(interceptor);
    return this;
  }

  Dio build() {
    Dio dio = Dio();
    dio.options =
        BaseOptions(contentType: "application/json", connectTimeout: connectTimeout, receiveTimeout: receiveTimeout);
    dio.options.baseUrl = baseUrl;
    if (headers.isNotEmpty) {
      dio.options.headers.addAll(headers);
    }
    if (interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
    return dio;
  }
}
