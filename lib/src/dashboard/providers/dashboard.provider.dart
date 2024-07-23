import 'package:education_app/core/common/providers/tab-navigator.provider.dart';
import 'package:education_app/core/common/views/persistent-view.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video-cubit.dart';
import 'package:education_app/src/course/presentation/cubit/course-cubit.dart';
import 'package:education_app/src/home/presentation/views/home.view.dart';
import 'package:education_app/src/notifications/presentation/cubit/notifications-cubit.dart';
import 'package:education_app/src/profile/presentation/views/profile.view.dart';
import 'package:education_app/src/quick-access/presentation/providers/quick-access.provider.dart';
import 'package:education_app/src/quick-access/presentation/views/quick-access.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashBoardProvider extends ChangeNotifier {
  List<int> _indexHistory = [0];
  int _currentIndex = 3;
  int get currentIndex => _currentIndex;
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CourseCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<VideoCubit>(),
              ),
              BlocProvider.value(
                value: getIt<NotificationsCubit>(),
              ),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (context) => getIt<CourseCubit>(),
            child: ChangeNotifierProvider(
              create: (_) => QuickAccessProvider(),
              child: const QuickAccessView(),
            ),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileView(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];
  List<Widget> get screens => _screens;
  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }
}
