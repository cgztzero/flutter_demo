import 'package:flutter/cupertino.dart';

import 'global_loading.dart';

class GlobalLoadingManage {
  final GlobalKey<GlobalLoadingState> _globalLoadingKey = GlobalKey<GlobalLoadingState>();

  get globalLoadingKey => _globalLoadingKey;

  Widget? _globalLoadingWidget;

  get globalLoadingWidget => _globalLoadingWidget;

  static GlobalLoadingManage? _instance;

  static GlobalLoadingManage of() {
    return _instance ??= GlobalLoadingManage();
  }

  void showLoading({bool canKeyBack = true, int disappearTime = 0, Widget? loadingWidget}) {
    _globalLoadingKey.currentState!
        .showLoading(canKeyBack: canKeyBack, disappearTime: disappearTime, loadingWidget: loadingWidget);
  }

  void hideLoading() {
    _globalLoadingKey.currentState!.hideLoading();
  }

  Widget createGlobalLoading() {
    return GlobalLoading(key: _globalLoadingKey);
  }

  void initGlobalLoadingWidget(Widget widget) {
    _globalLoadingWidget = widget;
  }
}
