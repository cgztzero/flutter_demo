import 'package:flutter/material.dart';
import 'package:flutter_base/page/banner/banner_page.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/route/route_delegate.dart';

import '../../widget/image/image_widget.dart';

class ImagePage extends BasePage {
  static const String path = '/imagePage';

  ImagePage({Map<String, dynamic>? params}) : super(params: params);

  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return ImageScreen(
      params: params,
    );
  }

  @override
  String getPath() {
    return path;
  }
}

class ImageScreen extends BaseStatefulScreen {
  ImageScreen({Key? key, Map<String, dynamic>? params}) : super(key: key, params: params);

  @override
  State<StatefulWidget> createState() {
    return ImageScreenState();
  }
}

class ImageScreenState<ImagePage> extends BaseStatefulScreenState {

  @override
  Widget createWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('ImagePage'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonImageWidget.network(
              imageUrl: getStringParam('url'),
              width: 300,
              height: 100,
              onImageTapCallback: () {
                debugPrint('networkImage click');
              },
              borderColor: Colors.white,
              borderWidth: 2,
              borderRadius: 5,
              pressColor: Colors.black38,
              margin: const EdgeInsets.only(bottom: 30),
            ),
            CommonImageWidget.asset(
              imageUrl: 'assets/portrait.png',
              width: 100,
              height: 100,
              onImageTapCallback: () {
                debugPrint('assetImage click');
              },
              borderColor: Colors.white,
              borderWidth: 2,
              borderRadius: 2,
              isCircle: true,
              pressColor: Colors.black26,
            ),
            ElevatedButton(onPressed: (){
              RouterDelegateImpl.of().push(path: BannerPage.path);
            }, child: Text('跳转banner'))
          ],
        ),
      ),
    );
  }
}
