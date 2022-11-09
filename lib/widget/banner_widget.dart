import 'package:flutter/material.dart';
import 'package:flutter_base/widget/preload_page_view.dart';

import 'image/image_widget.dart';

typedef ItemClickCallBack<T> = void Function(int index, BannerInfo<T> model);
typedef ItemBuilder = Widget Function<T>(BuildContext context, BannerInfo<T> model);
typedef ImageUrlBuilder = String Function<T>(BannerInfo<T> model);

enum BannerIndicatorPosition { leftBottom, centerBottom, rightBottom }

///轮播图
class BannerWidget<T> extends StatefulWidget {
  final List<BannerInfo<T>> list;
  final ItemClickCallBack? itemClickCallBack;
  final ImageUrlBuilder? imageUrlBuilder;
  final ItemBuilder? itemBuilder;
  final double width, height;
  final double itemMargin;
  final BannerIndicatorPosition indicatorPosition;
  final double indicatorRight, indicatorLeft, indicatorBottom;

  const BannerWidget.normal(
      {Key? key,
      required this.list,
      required this.itemClickCallBack,
      required this.imageUrlBuilder,
      this.itemBuilder,
      this.width = 300,
      this.height = 150,
      this.itemMargin = 0,
      this.indicatorPosition = BannerIndicatorPosition.rightBottom,
      this.indicatorRight = -1,
      this.indicatorLeft = -1,
      this.indicatorBottom = 10})
      : super(key: key);

  const BannerWidget.custom(
      {Key? key,
      required this.list,
      required this.itemBuilder,
      this.itemClickCallBack,
      this.imageUrlBuilder,
      this.width = 300,
      this.height = 150,
      this.itemMargin = 0,
      this.indicatorPosition = BannerIndicatorPosition.rightBottom,
      this.indicatorRight = -1,
      this.indicatorLeft = -1,
      this.indicatorBottom = 10})
      : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late BannerIndicator _bannerIndicator;
  final GlobalKey<_BannerIndicatorState> _globalKey = GlobalKey<_BannerIndicatorState>();

  @override
  void initState() {
    final int count = widget.list.length;
    _bannerIndicator = BannerIndicator(
      count: count,
      key: _globalKey,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> widgets = [];
    int length = widget.list.length;
    for (int index = 0; index < length; index++) {
      if (widget.itemBuilder != null) {
        widgets.add(widget.itemBuilder!(context, widget.list[index]));
      } else {
        widgets.add(_BannerItemWidget(
          info: widget.list[index],
          itemClickCallBack: widget.itemClickCallBack,
          imageUrlBuilder: widget.imageUrlBuilder,
          width: widget.width,
          height: widget.height,
          leftMargin: widget.itemMargin,
          rightMargin: widget.itemMargin,
          index: index,
        ));
      }
    }

    double indicatorLeft, indicatorRight;
    Positioned indicatorWidget;

    if (widget.indicatorPosition == BannerIndicatorPosition.leftBottom) {
      indicatorLeft = widget.indicatorLeft != -1 ? widget.indicatorLeft : 30;
      indicatorWidget = Positioned(
        child: _bannerIndicator,
        left: indicatorLeft + widget.itemMargin,
        bottom: widget.indicatorBottom,
      );
    } else if (widget.indicatorPosition == BannerIndicatorPosition.rightBottom) {
      indicatorRight = widget.indicatorRight != -1 ? widget.indicatorRight : 30;
      indicatorWidget = Positioned(
        child: _bannerIndicator,
        right: indicatorRight + widget.itemMargin,
        bottom: widget.indicatorBottom,
      );
    } else {
      indicatorWidget = Positioned(
        child: _bannerIndicator,
        bottom: widget.indicatorBottom,
      );
    }

    return Container(
        height: widget.height,
        width: widget.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PreloadPageView(
              children: widgets,
              onPageChanged: (int index) {
                _globalKey.currentState?.changeSelectIndex(index);
              },
            ),
            indicatorWidget
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class _BannerItemWidget<T> extends StatelessWidget {
  final BannerInfo<T> info;
  final ItemClickCallBack? itemClickCallBack;
  final ImageUrlBuilder? imageUrlBuilder;
  final double width, height;
  final double leftMargin, rightMargin;
  final int index;

  const _BannerItemWidget(
      {Key? key,
      required this.info,
      required this.itemClickCallBack,
      required this.imageUrlBuilder,
      this.width = 300,
      this.height = 100,
      this.leftMargin = 0,
      this.rightMargin = 0,
      this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: CommonImageWidget.network(
        onImageTapCallback: () {
          itemClickCallBack!(index, info);
        },
        imageUrl: imageUrlBuilder!(info),
        width: width,
        height: height,
        fit: BoxFit.cover,
        borderRadius: 10,
      ),
    );
  }
}

class BannerInfo<T> {
  final T value;

  BannerInfo(this.value);
}

typedef ChangeIndicator = void Function(int index);

class BannerIndicator extends StatefulWidget {
  final int count;

  const BannerIndicator({Key? key, this.count = 0}) : super(key: key);

  @override
  _BannerIndicatorState createState() => _BannerIndicatorState();
}

class _BannerIndicatorState extends State<BannerIndicator> {
  int selectedIndex = 0;

  void changeSelectIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < widget.count; i++) {
      if (i == selectedIndex) {
        list.add(Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: const Icon(
            Icons.adjust_rounded,
            color: Colors.red,
            size: 10,
          ),
        ));
      } else {
        list.add(Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: const Icon(
            Icons.adjust_rounded,
            color: Colors.white,
            size: 10,
          ),
        ));
      }
    }

    return IgnorePointer(
      child: Container(
        height: 12,
        color: Colors.black45,
        child:Row(
          children: list,
        ),
      ),
    );
  }
}