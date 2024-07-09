import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/home/presentation/widgets/home-app-bar.widget.dart';
import 'package:education_app/src/home/presentation/widgets/home-body.widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: HomeBody(),
      ),
    );
  }
}
