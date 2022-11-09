//断网回调
typedef OnDisconnect = void Function();
//http返回码不是200错误
typedef OnHttpCodeError = void Function({String url, String method, Map<String, dynamic>? params, int? statusCode});
//异常错误
typedef OnRequestException = void Function(
    {String url, String method, Map<String, dynamic>? params, Exception? exception});
