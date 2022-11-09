import 'package:flutter/material.dart';
import 'package:flutter_base/util/string_util.dart';

import 'image_config.dart';

typedef OnImageTapCallback = void Function();

class CommonImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double? width, height;
  final Map<String, String>? headers;
  final Widget? errorWidget;
  final String? errorImageUrl;
  final Color? errorColor;
  final String? placeImageUrl;
  final Color? placeImageColor;
  final OnImageTapCallback? onImageTapCallback;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final bool? isCircle;
  final Color? pressColor;
  final int? imageType;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;

  static const int netImageType = 0;
  static const int assetsImageType = 1;

  const CommonImageWidget.network(
      {Key? key,
      @required String? imageUrl,
      @required double? width,
      @required double? height,
      Map<String, String>? headers,
      String? errorImageUrl,
      Color? errorColor,
      Widget? errorWidget,
      String? placeImageUrl,
      Color? placeImageColor,
      OnImageTapCallback? onImageTapCallback,
      Color? borderColor,
      double? borderWidth,
      double? borderRadius,
      bool? isCircle,
      Color? pressColor,
      BoxFit? fit,
      EdgeInsetsGeometry? margin})
      : this._private(
            key: key,
            imageUrl: imageUrl,
            width: width,
            height: height,
            headers: headers,
            errorImageUrl: errorImageUrl,
            errorColor: errorColor,
            errorWidget: errorWidget,
            placeImageUrl: placeImageUrl,
            placeImageColor: placeImageColor,
            onImageTapCallback: onImageTapCallback,
            borderColor: borderColor,
            borderWidth: borderWidth,
            borderRadius: borderRadius,
            isCircle: isCircle,
            pressColor: pressColor,
            fit: fit,
            margin: margin,
            imageType: netImageType);

  const CommonImageWidget.asset(
      {Key? key,
      @required String? imageUrl,
      @required double? width,
      @required double? height,
      String? errorImageUrl,
      Color? errorColor,
      Widget? errorWidget,
      String? placeImageUrl,
      Color? placeImageColor,
      OnImageTapCallback? onImageTapCallback,
      Color? borderColor,
      double? borderWidth,
      double? borderRadius,
      bool? isCircle,
      BoxFit? fit,
      EdgeInsetsGeometry? margin,
      Color? pressColor})
      : this._private(
            key: key,
            imageUrl: imageUrl,
            width: width,
            height: height,
            errorImageUrl: errorImageUrl,
            errorColor: errorColor,
            errorWidget: errorWidget,
            placeImageUrl: placeImageUrl,
            placeImageColor: placeImageColor,
            onImageTapCallback: onImageTapCallback,
            borderColor: borderColor,
            borderWidth: borderWidth,
            borderRadius: borderRadius,
            isCircle: isCircle,
            pressColor: pressColor,
            fit: fit,
            margin: margin,
            imageType: assetsImageType);

  const CommonImageWidget._private(
      {Key? key,
      @required this.imageUrl,
      @required this.width,
      @required this.height,
      this.headers,
      this.errorImageUrl,
      this.errorColor,
      this.errorWidget,
      this.placeImageUrl,
      this.placeImageColor,
      this.onImageTapCallback,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.isCircle,
      this.pressColor,
      this.fit,
      this.margin,
      this.imageType})
      : super(key: key);

  @override
  State<CommonImageWidget> createState() {
    return _CommonImageWidgetState();
  }
}

class _CommonImageWidgetState extends State<CommonImageWidget> {
  bool _isPress = false;

  @override
  Widget build(BuildContext context) {
    Widget result = _getContentWidget();
    if (widget.onImageTapCallback != null) {
      result = GestureDetector(
        onTap: () {
          widget.onImageTapCallback!();
        },
        onTapDown: (TapDownDetails details) {
          if (_isAddPressColor()) {
            _isPress = true;
            setState(() {});
          }
        },
        onTapUp: (TapUpDetails details) {
          if (_isAddPressColor()) {
            _isPress = false;
            setState(() {});
          }
        },
        onTapCancel: () {
          if (_isAddPressColor()) {
            _isPress = false;
            setState(() {});
          }
        },
        child: result,
      );
    }
    if (widget.margin != null) {
      result = Container(
        margin: widget.margin,
        child: result,
      );
    }
    return result;
  }

  Widget _getContentWidget() {
    final bool circleImage = widget.isCircle ?? false;
    final double realRadius = circleImage ? widget.width! / 2 : widget.borderRadius ?? 0;
    final double realBorderWidth = widget.borderWidth ?? 0;
    final Color? realBorderColor = realBorderWidth != 0 ? widget.borderColor : null;

    return !StringUtil.isEmpty(widget.imageUrl)
        ? ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(realRadius)))),
            child: Container(
              color: realBorderColor,
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.all(realBorderWidth),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(realRadius)))),
                child: Stack(
                  children: [
                    _getImageWidget(),
                    Visibility(
                      visible: _isAddPressColor() && _isPress,
                      child: Container(
                        color: widget.pressColor ?? ImageGlobalConfig.pressColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  ///create image
  Widget _getImageWidget() {
    if (widget.imageType == null) {
      return Container();
    }
    if (widget.imageType == CommonImageWidget.netImageType) {
      return Image.network(
        widget.imageUrl!,
        width: widget.width,
        height: widget.height,
        headers: widget.headers ?? ImageGlobalConfig.defaultHeaders,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return _getErrorWidget();
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        isAntiAlias: true,
        fit: widget.fit ?? BoxFit.fill,
      );
    } else {
      return Image.asset(
        widget.imageUrl!,
        width: widget.width,
        height: widget.height,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return _getErrorWidget();
        },
        isAntiAlias: true,
        fit: widget.fit ?? BoxFit.fill,
      );
    }
  }

  ///determine whether add press color
  bool _isAddPressColor() {
    return widget.onImageTapCallback != null && (widget.pressColor != null || ImageGlobalConfig.pressColor != null);
  }

  ///create error widget
  Widget _getErrorWidget() {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    } else if (!StringUtil.isEmpty(widget.errorImageUrl)) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image.asset(
          widget.errorImageUrl!,
          width: widget.width,
          height: widget.height,
        ),
      );
    } else if (!StringUtil.isEmpty(ImageGlobalConfig.errorImageUrl)) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image.asset(
          ImageGlobalConfig.errorImageUrl!,
          width: widget.width,
          height: widget.height,
        ),
      );
    } else if (widget.errorColor != null) {
      return Container(
        color: widget.errorColor,
        width: widget.width,
        height: widget.height,
      );
    } else if (ImageGlobalConfig.errorColor != null) {
      return Container(
        color: ImageGlobalConfig.errorColor,
        width: widget.width,
        height: widget.height,
      );
    }
    return Container();
  }
}
