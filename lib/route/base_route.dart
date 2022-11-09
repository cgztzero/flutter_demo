import 'package:flutter/material.dart';

class AnimationRoute extends PageRoute {
  final WidgetBuilder widgetBuilder;
  final Duration duration;
  final Color transitionColor;
  final int? animType;

  static const int SlideAnim = 1;
  static const int FadeAnim = 2;
  static const int ScaleAnim = 3;

  AnimationRoute({
    required this.widgetBuilder,
    RouteSettings? settings,
    this.duration = const Duration(milliseconds: 300),
    this.transitionColor = Colors.transparent,
    this.animType = SlideAnim,
  }) : super(settings: settings);

  @override
  Color? get barrierColor => transitionColor;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return widgetBuilder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Widget animWidget;
    debugPrint('buildTransitions animType:$animType');
    // if (animType == SystemAnim) {
    //   final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    //   return theme.buildTransitions(this, context, animation, secondaryAnimation, child);
    // } else
    if (animType == SlideAnim) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      const curve = Curves.linear;
      var tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));
      animWidget = SlideTransition(position: animation.drive(tween), child: child);
    } else if (animType == FadeAnim) {
      animWidget = FadeTransition(opacity: animation, child: child);
    } else if (animType == ScaleAnim) {
      animWidget = ScaleTransition(scale: animation, child: child);
    } else {
      animWidget = child;
    }
    return animWidget;
  }
}
