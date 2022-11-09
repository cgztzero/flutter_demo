import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_base/page/base_screen.dart';
import 'package:flutter_base/route/base_page.dart';
import 'package:flutter_base/route/route_delegate.dart';
import 'package:flutter_base/widget/image/image_widget.dart';

class NestedScrollViewPage extends BasePage {
  static const String path = '/nestedScrollView';

  @override
  Widget createScreen(BuildContext context, Map<String, dynamic>? params) {
    return NestedScrollViewScreen();
  }

  @override
  String getPath() {
    return path;
  }
}

class NestedScrollViewScreen extends BaseStatefulScreen {
  NestedScrollViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NestedScrollViewScreenState();
}

class NestedScrollViewScreenState extends BaseStatefulScreenState {
  bool _canRefresh = false;
  bool _isRequesting = false;
  final ScrollController _controller = ScrollController();

  Widget _test() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        return true;
      },
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.red,
            expandedHeight: 200,
            title: const Text('Test title'),
            leading: GestureDetector(
                onTap: (){
                  RouterDelegateImpl.of().pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            pinned: true,
            stretch: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _getIcon(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('FlexibleSpaceBar title'),
              background: Image.network(
                'https://img0.baidu.com/it/u=892110681,2731910256&fm=253&fmt=auto&app=138&f=JPEG?w=727&h=481',
                fit: BoxFit.cover,
              ),
            ),
          ),
          buildImages()
        ],
      ),
    );
  }

  Widget _getIcon() {
    if (_isRequesting) {
      return const Icon(Icons.refresh);
    }

    return _canRefresh ? const Icon(Icons.refresh) : const Icon(Icons.settings);
  }

  Widget buildImages() {
    return SliverToBoxAdapter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        itemCount: 30,
        shrinkWrap: true,
      ),
    );
  }

  @override
  initState() {
    _controller.addListener(() {
      if (_controller.offset < -60) {
        if (!_canRefresh) {
          _canRefresh = true;
          setState(() {});
        }
      } else {
        if (_canRefresh) {
          _canRefresh = false;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget createWidget(BuildContext context) {
    return Scaffold(
      body: _test(),
    );
  }

  void _mockRequestHttp() {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      _isRequesting = false;
      setState(() {});
    });
  }
}
