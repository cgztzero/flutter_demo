import 'package:dio/dio.dart';

///dio base error handler
abstract class DioErrorExceptionHandler {
  bool onHandleDioError(DioError error);

  bool onHandleHttpError(Response response);

  bool onHandleException(Exception exception);
}
