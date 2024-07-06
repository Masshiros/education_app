import 'package:education_app/core/common/providers/tab-navigator.provider.dart';
import 'package:education_app/core/common/providers/user.provider.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();
  LocalUser? get currentUser => userProvider.user;
  TabNavigator get tabNavigator => read<TabNavigator>();
  void pop() => tabNavigator.pop();
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
