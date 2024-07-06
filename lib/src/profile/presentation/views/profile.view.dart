import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/profile/presentation/widgets/profile-app-bar.widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
