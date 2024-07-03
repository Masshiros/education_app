part of 'router.dart';

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
    case 'forgot-password':
      return _pageBuilder((_) => const fui.ForgotPasswordScreen(),
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
