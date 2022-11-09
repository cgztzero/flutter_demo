import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnRefresh = Future<void> Function();

class RefreshIndicatorWidget extends StatefulWidget {
  final Widget child;
  final OnRefresh onRefresh;
  final bool isAndroid;

  const RefreshIndicatorWidget({Key? key, required this.child, required this.onRefresh, this.isAndroid = true})
      : super(key: key);

  @override
  _RefreshIndicatorWidgetState createState() => _RefreshIndicatorWidgetState();
}

class _RefreshIndicatorWidgetState extends State<RefreshIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return _createWidget();
  }

  Widget _createWidget() {
    return widget.isAndroid ? _buildAndroidRefresh() : _buildIOSRefresh();
  }

  Widget _buildAndroidRefresh() {
    return RefreshIndicator(
      child: widget.child,
      onRefresh: widget.onRefresh,
      color: Colors.red,
      backgroundColor: Colors.greenAccent,
    );
  }

  Widget _buildIOSRefresh() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: widget.onRefresh,
        ),
        SliverToBoxAdapter(
          child: widget.child,
        )
      ],
    );
  }
}
