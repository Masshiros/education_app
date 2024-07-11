import 'package:education_app/core/global/colours.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.seeAll,
    required this.onSeeAll,
  });
  final String title;
  final bool seeAll;
  final VoidCallback onSeeAll;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColour,
              ),
            ),
          )
      ],
    );
  }
}
