import 'dart:io';

import 'package:education_app/core/common/widgets/titled-input-field.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/data/models/course.model.dart';
import 'package:education_app/src/course/presentation/cubit/course-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is AddingCourse) {
          loading = true;
          CoreUtils.snowLoadingDialog(context);
        } else if (state is CourseAdded) {
          if (loading) {
            loading = false;
            Navigator.pop(context);
          }
          CoreUtils.showSnackBar(context, 'Course added successfully');
          Navigator.pop(context);
        }
      },
      child: Padding(
          padding: EdgeInsets.only(
            bottom: context.mediaQuery.viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text(
                      'Add Course',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TitledInputField(
                      controller: titleController,
                      title: 'Course Title',
                    ),
                    const SizedBox(height: 20),
                    TitledInputField(
                      controller: descriptionController,
                      title: 'Description',
                      required: false,
                    ),
                    const SizedBox(height: 20),
                    TitledInputField(
                      controller: imageController,
                      title: 'Course Image',
                      required: false,
                      hintText: 'Enter image URL or pick from gallery',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final image = await CoreUtils.pickImage();
                          if (image != null) {
                            isFile = true;
                            this.image = image;
                            final imageName = image.path.split('/').last;
                            imageController.text = imageName;
                          }
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final now = DateTime.now();
                                final course = CourseModel.empty().copyWith(
                                  title: titleController.text.trim(),
                                  description:
                                      descriptionController.text.trim(),
                                  image: imageController.text.trim().isEmpty
                                      ? kDefaultAvatar
                                      : isFile
                                          ? image!.path
                                          : imageController.text.trim(),
                                  createdAt: now,
                                  updatedAt: now,
                                  imageIsFile: isFile,
                                );
                                context.read<CourseCubit>().addCourse(course);
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ))
                      ],
                    )
                  ],
                )),
          )),
    );
  }
}
