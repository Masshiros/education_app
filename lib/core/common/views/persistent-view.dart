import 'package:education_app/core/common/providers/tab-navigator.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});
  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: widget.body ?? context.watch<TabNavigator>().currentPage.child);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
