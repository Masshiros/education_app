part of 'router.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = getIt<SharedPreferences>();
      final currentUser = getIt<FirebaseAuth>().currentUser;

      return _pageBuilder((context) {
        if (prefs.getBool(kFirstTimerKey) ?? true) {
          return BlocProvider(
            create: (_) => getIt<OnBoardingCubit>(),
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
    case CourseDetailsScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailsScreen(course: settings.arguments as Course),
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case DashBoardScreen.routeName:
      return _pageBuilder(
        (_) => const DashBoardScreen(),
        settings: settings,
      );
    case 'forgot-password':
      return _pageBuilder((_) => const fui.ForgotPasswordScreen(),
          settings: settings);
    case AddVideoView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<CourseCubit>()),
            BlocProvider(create: (_) => getIt<VideoCubit>()),
            BlocProvider(create: (_) => getIt<NotificationsCubit>()),
          ],
          child: const AddVideoView(),
        ),
        settings: settings,
      );
    case AddResourcesView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<CourseCubit>()),
            BlocProvider(create: (_) => getIt<ResourceCubit>()),
            BlocProvider(create: (_) => getIt<NotificationsCubit>()),
          ],
          child: const AddResourcesView(),
        ),
        settings: settings,
      );
    case AddExamsView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<CourseCubit>()),
            BlocProvider(create: (_) => getIt<ExamCubit>()),
            BlocProvider(create: (_) => getIt<NotificationsCubit>()),
          ],
          child: const AddExamsView(),
        ),
        settings: settings,
      );
    case VideoPlayerView.routeName:
      return _pageBuilder(
        (_) => VideoPlayerView(videoURL: settings.arguments! as String),
        settings: settings,
      );
    case CourseVideosView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => getIt<VideoCubit>(),
          child: CourseVideosView(settings.arguments! as Course),
        ),
        settings: settings,
      );
      case CourseResourcesView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => getIt<ResourceCubit>(),
          child: CourseResourcesView(settings.arguments! as Course),
        ),
        settings: settings,
      );
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
