import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/on-boarding/domain/entities/page-content.dart';
import 'package:education_app/src/on-boarding/presentation/cubit/cubit/on-boarding-cubit.dart';
import 'package:education_app/src/on-boarding/presentation/widgets/on-boarding-body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserFirstTimerUseCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
