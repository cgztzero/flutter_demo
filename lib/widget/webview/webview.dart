import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef PageFinishedCallback = void Function(String url, String? title);

class BaseWebView extends StatefulWidget {
  final String? url;
  final PageFinishedCallback? pageFinishedCallback;

  const BaseWebView({Key? key, this.url, this.pageFinishedCallback}) : super(key: key);

  @override
  BaseWebViewState createState() => BaseWebViewState();
}

class BaseWebViewState extends State<BaseWebView> {
  late WebViewController _webViewController;
  final GlobalKey<_WebViewIndicatorState> _globalKey = GlobalKey();

  Future<bool> goBack() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return true;
    }

    return false;
  }

  Future<String?> getWebTitle() async {
    return _webViewController.getTitle();
  }

  void reload() {
    _webViewController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          WebViewIndicator(
            key: _globalKey,
          ),
          Expanded(
              child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (!request.url.startsWith('http')) {
                return NavigationDecision.prevent;
              } else {
                return NavigationDecision.navigate;
              }
            },
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
            onPageFinished: (String url) async {
              if (widget.pageFinishedCallback != null) {
                String? title = await _webViewController.getTitle();
                widget.pageFinishedCallback!(url, title);
              }
            },
            onProgress: (int progress) {
              _globalKey.currentState?.changeProgress(progress);
            },
          ))
        ],
      ),
    );
  }
}

typedef WebViewProgressCallBack = void Function(int progress);

class WebViewIndicator extends StatefulWidget {
  const WebViewIndicator({Key? key}) : super(key: key);

  @override
  _WebViewIndicatorState createState() => _WebViewIndicatorState();
}

class _WebViewIndicatorState extends State<WebViewIndicator> {
  double _progress = 0;

  void changeProgress(int progress) {
    _progress = progress / 100;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        child: LinearProgressIndicator(
          minHeight: 5,
          value: _progress,
          color: Colors.blue,
          backgroundColor: Colors.grey,
        ),
        visible: _progress < 1);
  }
}
