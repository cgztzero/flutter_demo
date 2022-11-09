import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/util/print_util.dart';

///request log interceptors
class NetLogInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("=================================Dio 请求数据 =================================");
    Map httpLogMap = {};
    httpLogMap.putIfAbsent("requestMethod", () => options.method.toString());
    httpLogMap.putIfAbsent("requestUrl", () => options.uri.toString());
    httpLogMap.putIfAbsent("requestHeaders", () => options.headers);
    httpLogMap.putIfAbsent("requestParams", () => options.data);
    PrintUtil.printJson(httpLogMap);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("\n=================================Dio 响应数据开始 =================================");
    Map httpLogMap = {};
    httpLogMap.putIfAbsent("respondData", () => response.data);
    PrintUtil.printJson(httpLogMap);
    debugPrint("=================================Dio 响应数据结束 =================================\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError e, ErrorInterceptorHandler handler) {
    debugPrint("\n=================================Dio 错误响应数据 =================================");
    Map httpLogMap = {};
    httpLogMap.putIfAbsent("type", () => e.type);
    httpLogMap.putIfAbsent("message", () => e.message);
    PrintUtil.printJson(httpLogMap);
    super.onError(e, handler);
  }
}
