import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({super.key, required this.title, required this.icon});
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        icon
      ],
    );
  }
}
