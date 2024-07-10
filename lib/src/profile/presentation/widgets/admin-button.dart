import 'package:education_app/core/global/colours.dart';
import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  const AdminButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed});
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
