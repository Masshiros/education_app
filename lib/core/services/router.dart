import 'package:education_app/core/common/views/page-under-construction.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/on-boarding/presentation/cubit/cubit/on-boarding-cubit.dart';
import 'package:education_app/src/on-boarding/presentation/views/on-boarding.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (context) => getIt<OnBoardingCubit>(),
                child: const OnBoardingScreen(),
              ),
          settings: settings);
    default:
      return _pageBuilder((_) => const PageUnderConstruction(),
          settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(Widget Function(BuildContext) page,
    {required RouteSettings settings}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
