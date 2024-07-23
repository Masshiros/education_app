
import 'package:education_app/src/quick-access/presentation/providers/quick-access.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabTile extends StatelessWidget {
  const TabTile({required this.index, required this.title, super.key});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickAccessProvider>(
      builder: (_, controller, __) {
        final isSelected = controller.currentIndex == index;
        return GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: isSelected
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
        );
      },
    );
  }
}
