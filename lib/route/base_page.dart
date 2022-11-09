import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/route/base_route.dart';

abstract class BasePage extends Page {
  final Completer<dynamic> _completer = Completer();
  final Duration duration;
  final Color transitionColor;
  int? animType;
  final Map<String, dynamic> params = {};

  Widget createScreen(BuildContext context, Map<String, dynamic>? params);

  String getPath();

  BasePage(
      {LocalKey? key,
      String? name,
      Object? arguments,
      String? restorationId,
      this.duration = const Duration(milliseconds: 300),
      this.transitionColor = Colors.transparent,
      this.animType = AnimationRoute.SlideAnim,
      Map<String, dynamic>? params})
      : super(key: key, name: name, arguments: arguments, restorationId: restorationId) {
    if (params != null) {
      this.params.addAll(params);
    }
  }

  @override
  Route createRoute(BuildContext context) {
    debugPrint('createRoute');
    return AnimationRoute(
        settings: this,
        duration: duration,
        transitionColor: transitionColor,
        animType: animType,
        widgetBuilder: (cxt) {
          return createScreen(cxt, params);
        });
  }

  void setResult(dynamic result) {
    _completer.complete(result);
  }

  Future<dynamic> getResult() {
    return _completer.future;
  }

  void setAnim(int anim){
    animType = anim;
  }
}
