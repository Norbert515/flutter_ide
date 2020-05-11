import 'package:flutter/material.dart';

/// Navigator.of(context).push(FadeRoute(
///   builder: (context) {
///     return NewPage();
///   }
/// ));
class NoTransitionRoute extends PageRoute {

  NoTransitionRoute({@required this.builder});

  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;


  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class SlideTransitionRoute extends PageRoute {

  SlideTransitionRoute({@required this.builder});

  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return SlideTransition(
      //position: animation,
      child: builder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}