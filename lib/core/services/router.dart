import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/src/on_boarding/presentation/on-boarding.screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case OnBoardingScreen.routeName:
    //   return _pageBuilder(const OnBoardingScreen(), settings: settings);
    default:
      return _pageBuilder(const PageUnderConstruction(), settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(Widget page,
    {required RouteSettings settings}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page,
  );
}
