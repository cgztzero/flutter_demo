import 'package:flutter/material.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/route/route_delegate.dart';
import 'package:flutter_base/util/string_util.dart';
import 'package:flutter_base/widget/webview/webview.dart';

class WebViewPage extends BasePage {
  static const String path = '/webView';

  WebViewPage({required String url}) : super(params: {'url': url});

  static Future<dynamic> push({required String url}) {
    return RouterDelegateImpl.of().push(path: WebViewPage.path, params: {'url': url});
  }

  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return WebViewScreen(params: params);
  }

  @override
  String getPath() {
    return path;
  }
}

class WebViewScreen extends BaseStatefulScreen {
  WebViewScreen({Key? key, Map<String, dynamic>? params}) : super(key: key, params: params);

  @override
  State<StatefulWidget> createState() => WebViewState();
}

class WebViewState extends BaseStatefulScreenState {
  final GlobalKey<BaseWebViewState> _globalKey = GlobalKey();
  String _title = 'WebPage';

  @override
  Widget createWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: BackButton(
          onPressed: () async {
            if (await _globalKey.currentState!.goBack()) {
              return;
            }
            RouterDelegateImpl.of().maybePop(context);
          },
        ),
      ),
      body: BaseWebView(
        key: _globalKey,
        url: getStringParam('url'),
        pageFinishedCallback: (url, title) {
          if (!StringUtil.isEmpty(title)) {
            _title = title!;
            setState(() {});
          }
        },
      ),
    );
  }
}
