import 'package:education_app/core/extensions/context.extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          try {
            context.pop();
            return false;
          } catch (_) {
            return true;
          }
        },
        child: IconButton(
          onPressed: () {
            try {
              context.pop();
            } catch (_e) {
              Navigator.of(context).pop();
            }
          },
          icon: Theme.of(context).platform == TargetPlatform.iOS
              ? const Icon(Icons.arrow_back_ios)
              : const Icon(Icons.arrow_back),
        ));
  }
}
