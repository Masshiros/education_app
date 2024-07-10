import 'dart:io';

import 'package:flutter/material.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  bool isFile = false;

  bool loading = false;
  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      if (isFile && imageController.text.trim().isEmpty) {
        image = null;
        isFile = false;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
