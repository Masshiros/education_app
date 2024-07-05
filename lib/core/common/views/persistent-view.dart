import 'package:education_app/core/common/providers/tab-navigator.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});
  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.body ?? context.read<TabNavigator>().currentPage.child);
  }
}
