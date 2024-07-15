
import 'package:education_app/core/global/media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoNotifications extends StatelessWidget {
  const NoNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(MediaRes.noNotifications));
  }
}
