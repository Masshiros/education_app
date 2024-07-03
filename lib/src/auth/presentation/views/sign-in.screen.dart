import 'package:education_app/core/extensions/context.extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign-in';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("SIGN IN SCREEN", style: context.theme.textTheme.bodyLarge),
    );
  }
}
