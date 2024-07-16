
import 'package:education_app/core/global/colours.dart';
import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  const InfoField({
    required this.controller,
    super.key,
    this.onEditingComplete,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.labelText,
    this.focusNode,
    this.onTapOutside,
    this.onChanged,
    this.border = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final TextInputType keyboardType;
  final bool autoFocus;
  final String? labelText;
  final FocusNode? focusNode;

  final ValueChanged<PointerDownEvent>? onTapOutside;
  final ValueChanged<String?>? onChanged;
  final bool border;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColour),
    );
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return TextField(
          controller: controller,
          autofocus: autoFocus,
          focusNode: focusNode,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          onTapOutside: onTapOutside ??
              (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: border ? defaultBorder : null,
            enabledBorder: border ? defaultBorder : null,
            contentPadding:
                border ? const EdgeInsets.symmetric(horizontal: 10) : null,
            suffixIcon: suffixIcon ??
                (controller.text.trim().isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: controller.clear,
                      )),
          ),
        );
      },
    );
  }
}
