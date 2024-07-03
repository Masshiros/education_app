import 'package:education_app/core/extensions/context.extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("DASHBOARD SCREEN", style: context.theme.textTheme.bodyLarge),
    );
  }
}
