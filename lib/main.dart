import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/net_business/http_manager.dart';
import 'package:flutter_base/route/base_information_parser.dart';
import 'package:flutter_base/route/route_delegate.dart';
import 'package:flutter_base/widget/loading/global_loading_manage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'net_business/dio_http_client_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RouterDelegateImpl _delegateImpl = RouterDelegateImpl.of();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    HttpManager.init(DioIHttpClientImpl(isDebug: true));
    _delegateImpl.initHome();
    GlobalLoadingManage.of()
        .initGlobalLoadingWidget(const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: RouteInformationParserImpl(),
        routerDelegate: _delegateImpl);
  }
}
