import 'package:education_app/core/extensions/context.extension.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/sign-up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("SIGN UP SCREEN", style: context.theme.textTheme.bodyLarge),
    );
  }
}
