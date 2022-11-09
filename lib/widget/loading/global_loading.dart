import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/widget/loading/global_loading_manage.dart';

class GlobalLoading extends StatefulWidget {
  const GlobalLoading({Key? key}) : super(key: key);

  @override
  GlobalLoadingState createState() => GlobalLoadingState();
}

class GlobalLoadingState extends State<GlobalLoading> {
  bool isShow = false;
  bool canBack = true;
  int _disappearTime = 0;
  Widget? _loadingWidget;

  void showLoading({bool canKeyBack = true, int disappearTime = 0, Widget? loadingWidget}) {
    if (isShow) {
      return;
    }
    isShow = true;
    canBack = canKeyBack;
    _disappearTime = disappearTime;
    if (loadingWidget != null) {
      _loadingWidget = loadingWidget;
    }
    if (_disappearTime != 0) {
      Future.delayed(Duration(milliseconds: _disappearTime)).then((value) => hideLoading());
    }
    setState(() {});
  }

  void hideLoading() {
    if (!isShow) {
      return;
    }
    isShow = false;
    canBack = true;
    _disappearTime = 0;
    _loadingWidget = null;
    setState(() {});
  }

  Widget _getLoadingWidget() {
    if (_loadingWidget != null) {
      return _loadingWidget!;
    }
    return GlobalLoadingManage.of().globalLoadingWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: WillPopScope(
        onWillPop: () async {
          return canBack;
        },
        child: AbsorbPointer(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: _getLoadingWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
