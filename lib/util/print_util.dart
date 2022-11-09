import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PrintUtil {
  //带有首行缩进的Json格式
  static const JsonEncoder _encoder =  JsonEncoder.withIndent('  ');

  /// 单纯的Json格式输出打印
  static void printJson(Object object) {
    try {
      var encoderString = _encoder.convert(object);
      encoderString.split('\n').forEach((element) => debugPrint(element));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
