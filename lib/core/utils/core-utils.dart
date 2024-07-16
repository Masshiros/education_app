import 'dart:io';

import 'package:education_app/core/enums/notifications.enum.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/src/notifications/data/models/notification.models.dart';
import 'package:education_app/src/notifications/presentation/cubit/notifications-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static void sendNotification(
    BuildContext context, {
    required String title,
    required String body,
    required ENotification category,
  }) {
    context.read<NotificationsCubit>().sendNotification(
          NotificationModel.empty().copyWith(
            title: title,
            body: body,
            category: category,
          ),
        );
  }
}
