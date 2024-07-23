import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/quick-access/presentation/widget/quick-access-app-bar.widget.dart';
import 'package:education_app/src/quick-access/presentation/widget/quick-access-header.widget.dart';
import 'package:education_app/src/quick-access/presentation/widget/quick-access-tab-bar.widget.dart';
import 'package:education_app/src/quick-access/presentation/widget/quick-access-tab-body.widget.dart';
import 'package:flutter/material.dart';

class QuickAccessView extends StatelessWidget {
  const QuickAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: QuickAccessAppBar() ,
      body: GradientBackground(image: MediaRes.documentsGradientBackground,child: Center( child: Column(
            children: [
              Expanded(flex: 2, child: QuickAccessHeader()),
              Expanded(child: QuickAccessTabBar()),
              Expanded(flex: 2, child: QuickAccessTabBody()),
            ],
          ),), ),
    );
  }
}
