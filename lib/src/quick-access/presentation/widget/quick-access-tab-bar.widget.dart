
import 'package:education_app/src/quick-access/presentation/widget/tab-tile.widget.dart';
import 'package:flutter/material.dart';

class QuickAccessTabBar extends StatelessWidget {
  const QuickAccessTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabTile(index: 0, title: 'Document'),
        TabTile(index: 1, title: 'Exam'),
        TabTile(index: 2, title: 'Passed'),
      ],
    );
  }
}
