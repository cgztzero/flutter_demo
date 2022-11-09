import 'package:flutter/cupertino.dart';

abstract class BaseStatefulScreen extends StatefulWidget {
  final Map<String, dynamic> params = {};

  BaseStatefulScreen({Key? key, Map<String, dynamic>? params}) : super(key: key) {
    if (params != null) {
      this.params.addAll(params);
    }
  }

  int getIntParam(String key, {int defaultValue = -1}) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return defaultValue;
  }

  String getStringParam(String key, {String defaultValue = ''}) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return defaultValue;
  }

  T? getDynamicParam<T extends Object>(String key) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return null;
  }
}

abstract class BaseStatefulScreenState<T extends BaseStatefulScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return createWidget(context);
  }

  Widget createWidget(BuildContext context);

  int getIntParam(String key, {int defaultValue = -1}) {
    return widget.getIntParam(key, defaultValue: defaultValue);
  }

  String getStringParam(String key, {String defaultValue = ''}) {
    return widget.getStringParam(key, defaultValue: defaultValue);
  }

  T? getDynamicParam<T extends Object>(String key) {
    return widget.getDynamicParam(key);
  }
}

abstract class BaseStateLessScreen extends StatelessWidget {
  final Map<String, dynamic> params = {};

  BaseStateLessScreen({Key? key, Map<String, dynamic>? params}) : super(key: key) {
    if (params != null) {
      this.params.addAll(params);
    }
  }

  int getIntParam(String key, {int defaultValue = -1}) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return defaultValue;
  }

  String getStringParam(String key, {String defaultValue = ''}) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return defaultValue;
  }

  T? getDynamicParam<T extends Object>(String key) {
    if (params.containsKey(key)) {
      return params[key];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return createWidget(context);
  }

  Widget createWidget(BuildContext context);
}

