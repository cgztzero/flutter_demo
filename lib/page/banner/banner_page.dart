import 'package:flutter/material.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/page/image/image_page.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/route/route_delegate.dart';
import 'package:flutter_base/widget/banner_widget.dart';

class BannerPage extends BasePage {
  static const String path = '/bannerPage';

  @override
  String getPath() {
    return path;
  }

  @override
  Widget createScreen(BuildContext context,Map<String, dynamic>? params) {
    return BannerScreen();
  }
}

class BannerScreen extends BaseStateLessScreen {
  BannerScreen({Key? key}) : super(key: key);

  @override
  Widget createWidget(BuildContext context) {
    final _bannerList = <BannerInfo<String>>[];
    _bannerList
        .add(BannerInfo('https://img0.baidu.com/it/u=329459380,3434082451&fm=253&fmt=auto&app=120&f=JPEG?w=700&h=394'));
    _bannerList.add(
        BannerInfo('https://img2.baidu.com/it/u=2827110311,4110515683&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=312'));
    _bannerList.add(
        BannerInfo('https://img1.baidu.com/it/u=2374960005,3369337623&fm=253&fmt=auto&app=120&f=JPEG?w=499&h=312'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('BannerPage'),
      ),
      body: Center(
        child: Column(
          children: [
            BannerWidget.normal(
                width: double.infinity,
                itemMargin: 20,
                list: _bannerList,
                itemClickCallBack: <String>(int index, BannerInfo info) {
                  debugPrint('itemClickCallBack：$index');
                },
                imageUrlBuilder: <String>(BannerInfo info) {
                  return info.value;
                }),
            ElevatedButton(onPressed: (){
              RouterDelegateImpl.of().removePageByPath(path: ImagePage.path);
            }, child: const Text('remove imagePage'))
          ],
        ),
      ),
    );
  }
}


