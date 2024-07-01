import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/global/media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      image: MediaRes.onBoardingBackground,
      child: SafeArea(
        child: Lottie.asset(MediaRes.pageUnderConstruction),
      ),
    );
  }
}
