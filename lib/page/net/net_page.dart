import 'package:flutter/material.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/page/net/post_entity.dart';
import 'package:flutter_base/page/webview/webview_page.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/route/route_delegate.dart';
import 'package:flutter_base/util/string_util.dart';
import 'package:flutter_base/widget/refresh/refresh_widget.dart';

import '../../net_business/dio_http_client_impl.dart';
import '../../net_business/http_manager.dart';

class NetPage extends BasePage {
  static const String path = '/netPage';

  @override
  String getPath() {
    return path;
  }

  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return NetScreen();
  }
}

class NetScreen extends BaseStatefulScreen {
  NetScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NetScreenState();
  }
}

class NetScreenState extends BaseStatefulScreenState {
  final List<PostEntity> _list = [];
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final bool isAndroidStyle = true;
  int page = 0;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _requestHttp();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget createWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('NetPage'),
      ),
      body: RefreshIndicatorWidget(
        key: _refreshKey,
        isAndroid: isAndroidStyle,
        onRefresh: () async {
          //mock network weak
          await Future.delayed(Duration(milliseconds: 2000));
          page = 0;
          return await _requestHttp();
        },
        child: ListView.builder(
            controller: _controller,
            shrinkWrap: isAndroidStyle ? false : true,
            // primary: isAndroidStyle ? true : false,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index == _list.length) {
                return SizedBox(
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final postEntity = _list[index];
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith((states) {
                        return const RoundedRectangleBorder(borderRadius: BorderRadius.zero);
                      }),
                          backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                                return Colors.white70;
                            } else {
                              return Colors.white;
                            }}),
                          padding: MaterialStateProperty.all(EdgeInsets.all(0))
                      ),
                      onPressed: () {
                        Map<String, dynamic> params = {'url': postEntity.link};
                        RouterDelegateImpl.of().push(path: WebViewPage.path, params: params);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                '${postEntity.title}\n',
                                style: const TextStyle(fontSize: 20, color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text('${postEntity.author}',
                                    style: const TextStyle(fontSize: 12, color: Colors.black87))),
                            Text('${postEntity.niceDate}', style: const TextStyle(fontSize: 12, color: Colors.black45)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: Colors.black)
                ],
              );
            },
            itemCount: _list.length + 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _requestHttp();
        },
        child: const Icon(Icons.download),
      ),
    );
  }

  Future<void> _requestHttp() async {
    HttpManager httpManager = HttpManager.getInstance();
    Map<String, dynamic> map = await httpManager.getRequest('article/list/$page/json', onDisconnect: () {
      debugPrint('no network');
    });
    List<dynamic> list = map['data']['datas'];
    List<PostEntity> data = [];
    for (var json in list) {
      data.add(PostEntity.fromJson(json));
    }
    _list.addAll(data);
    page++;
    setState(() {});
  }
}
