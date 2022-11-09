import 'package:flutter/material.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/widget/loading/global_loading_manage.dart';

class LoadingPage extends BasePage {
  static const String path = '/loading';

  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return LoadingScreen();
  }

  @override
  String getPath() {
    return path;
  }
}

class LoadingScreen extends BaseStateLessScreen {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget createWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('loadingPage'),),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              GlobalLoadingManage.of().showLoading(canKeyBack: true, disappearTime: 5000);
            }, child: const Text('show loading,disappear 5s later')),
            ElevatedButton(onPressed: () {
              GlobalLoadingManage.of().showLoading(canKeyBack: true,
                  disappearTime: 5000, loadingWidget: _createLoading());
            }, child: const Text('show custom loading,disappear 5s later'))
          ],
        ),
      ),
    );
  }

  Widget _createLoading() {
    return Material(
      child: Container(width: 200, height: 200, color: Colors.red,
        child: const Center(
          child: Text('whatever custom loading'),
        ),),
    );
  }

}