import 'package:flutter/material.dart';

class Navigation{
  static PageRouteBuilder animationRoute({required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, animationTwo) => child,
        transitionsBuilder: (context, animation, animationTwo, child) {
          double begin = 0.0;
          double end = 1.0;
          Tween<double> tween = Tween(begin:begin, end:end );
          CurvedAnimation curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
          return ScaleTransition(scale: tween.animate(curvesAnimation),child: child,);
        }
    );
  }
}