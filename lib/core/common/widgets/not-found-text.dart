import 'package:education_app/core/extensions/context.extension.dart';
import 'package:flutter/material.dart';

class NotFoundText extends StatelessWidget {
  const NotFoundText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
