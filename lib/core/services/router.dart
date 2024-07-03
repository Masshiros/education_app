import 'package:education_app/core/common/views/page-under-construction.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:education_app/src/auth/presentation/bloc/auth-bloc.dart';
import 'package:education_app/src/auth/presentation/views/sign-in.screen.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard.screen.dart';
import 'package:education_app/src/on-boarding/data/datasources/on-boarding-local-data-source.dart';
import 'package:education_app/src/on-boarding/presentation/cubit/cubit/on-boarding-cubit.dart';
import 'package:education_app/src/on-boarding/presentation/views/on-boarding.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = getIt<SharedPreferences>();
      final currentUser = getIt<FirebaseAuth>().currentUser;

      return _pageBuilder((context) {
        if (prefs.getBool(kFirstTimerKey) ?? true) {
          return BlocProvider(
            create: (context) => getIt<OnBoardingCubit>(),
            child: const OnBoardingScreen(),
          );
        } else if (currentUser != null) {
          final user = currentUser!;
          final localUser = LocalUserModel(
            uid: user.uid,
            email: user.email ?? '',
            points: 0,
            fullName: user.displayName ?? '',
          );
          context.userProvider.initUser(localUser);
          return const DashBoardScreen();
        }
        return BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const SignInScreen(),
        );
      }, settings: settings);

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
