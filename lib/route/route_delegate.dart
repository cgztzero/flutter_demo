import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/page/banner/banner_page.dart';
import 'package:flutter_base/page/home.dart';
import 'package:flutter_base/page/image/image_page.dart';
import 'package:flutter_base/page/loading/loading_page.dart';
import 'package:flutter_base/page/nestedscrolll/nested_scrollview_page.dart';
import 'package:flutter_base/page/net/net_page.dart';
import 'package:flutter_base/page/webview/webview_page.dart';
import 'package:flutter_base/widget/loading/global_loading.dart';
import 'package:flutter_base/widget/loading/global_loading_manage.dart';

import 'base_page.dart';

class RouterDelegateImpl extends RouterDelegate<Object>
    with ChangeNotifier,PopNavigatorRouterDelegateMixin<Object> {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();
  final List<BasePage> allPages = [];

  static RouterDelegateImpl? _instance;

  static RouterDelegateImpl of() {
    _instance ??= RouterDelegateImpl();
    return _instance!;
  }

  void initHome() {
    allPages.add(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Navigator(
          key: navigatorKey,
          pages: List.of(allPages),
          onPopPage: _onPopPageCallBack,
        ),
        GlobalLoadingManage.of().createGlobalLoading()
      ],
    );
  }

  bool _onPopPageCallBack(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    final lastPage = allPages.removeLast();
    if (result != null) {
      lastPage.setResult(result);
    }
    notifyListeners();
    return true;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _globalKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value();
  }

  Future<dynamic> push({required String path, Map<String, dynamic>? params, Duration? duration, int? animType}) {
    var page = _createPage(path: path, params: params, duration: duration, animType: animType);
    allPages.add(page);
    debugPrint('push route');
    notifyListeners();
    return page.getResult();
  }

  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  Future<bool> maybePop<T extends Object?>(BuildContext context, [T? result]) {
    return Navigator.maybePop(context, result);
  }

  bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  void removePageByPath({required String path, bool clearAll = false}) {
    int index = allPages.length - 1;
    for (index; index >= 0; index--) {
      if (allPages[index].getPath() == path) {
        allPages.removeAt(index);
        notifyListeners();
        break;
      }
    }
  }

  BasePage _createPage({required String path, Map<String, dynamic>? params, Duration? duration, int? animType}) {
    BasePage page;
    switch (path) {
      case NestedScrollViewPage.path:
        page = NestedScrollViewPage();
        break;
      case WebViewPage.path:
        page = WebViewPage(url: params!['url']);
        break;
      case LoadingPage.path:
        page = LoadingPage();
        break;
      case ImagePage.path:
        page = ImagePage(params: params);
        break;
      case NetPage.path:
        page = NetPage();
        break;
      case BannerPage.path:
        page = BannerPage();
        break;
      default:
        page = HomePage();
        break;
    }
    if (animType != null) {
      page.setAnim(animType);
    }

    return page;
  }
}
