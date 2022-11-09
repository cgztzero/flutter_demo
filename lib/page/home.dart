import 'package:flutter/material.dart';
import 'package:flutter_base/page/banner/banner_page.dart';
import 'package:flutter_base/page/image/image_page.dart';
import 'package:flutter_base/page/loading/loading_page.dart';
import 'package:flutter_base/page/nestedscrolll/nested_scrollview_page.dart';
import 'package:flutter_base/page/net/net_page.dart';
import 'package:flutter_base/page/webview/webview_page.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/widget/loading/global_loading_manage.dart';

import '../route/base_route.dart';
import '../route/route_delegate.dart';

class HomePage extends BasePage {
  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return const HomeScreen();
  }

  @override
  String getPath() {
    return '/';
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    String imageUrl =
                        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbkimg.cdn.bcebos.com%2Fpic%2Fd4628535e5dde7117e3ce2f3a0efce1b9c1661cd&refer=http%3A%2F%2Fbkimg.cdn.bcebos.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649474552&t=4bbe41bf63930f1ab3f96c12fd20e18e';
                    Map<String, dynamic> map = {};
                    map['url'] = imageUrl;
                    RouterDelegateImpl.of().push(path: ImagePage.path, params: map);
                  },
                  child: const Text('ImagePage slide anim')),
              ElevatedButton(
                  onPressed: () {
                    RouterDelegateImpl.of().push(path: NetPage.path, animType: AnimationRoute.FadeAnim);
                  },
                  child: const Text('NetPage fade anim')),
              ElevatedButton(
                  onPressed: () {
                    RouterDelegateImpl.of().push(path: BannerPage.path);
                  },
                  child: const Text('Banner')),
              ElevatedButton(
                  onPressed: () {
                    RouterDelegateImpl.of().push(path: LoadingPage.path);
                  },
                  child: const Text('LoadingPage')),
              ElevatedButton(
                  onPressed: () {
                    WebViewPage.push(url: 'https://www.baidu.com/');
                  },
                  child: const Text('WebPage')),
              ElevatedButton(
                  onPressed: () {
                    RouterDelegateImpl.of().push(path: NestedScrollViewPage.path);
                  },
                  child: const Text('NestedScrollViewPage'))
            ],
          ),
        ));
  }
}
