
import 'package:flutter/material.dart';

class ReactiveButton extends StatelessWidget {
  const ReactiveButton({
    required this.loading,
    required this.disabled,
    required this.text,
    super.key,
    this.onPressed,
  });

  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;
  final String text;

  bool get normal => !loading && !disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: normal ? onPressed : null,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Text(text),
    );
  }
}
