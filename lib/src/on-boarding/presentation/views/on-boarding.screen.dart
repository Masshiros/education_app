import 'package:education_app/src/on-boarding/presentation/cubit/cubit/on-boarding-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {});
  }
}
