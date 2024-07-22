import 'dart:convert';
import 'dart:io';

import 'package:education_app/core/common/widgets/course-picker.dart';
import 'package:education_app/core/enums/notifications.enum.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/exams/data/models/exam.models.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam-cubit.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification-wrapper.widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddExamsView extends StatefulWidget {
  const AddExamsView({super.key});
  static const routeName = '/add-exams';
  @override
  State<AddExamsView> createState() => _AddExamsViewState();
}

class _AddExamsViewState extends State<AddExamsView> {
  File? examFile;
  final formKey = GlobalKey<FormState>();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);
  Future<void> pickExamFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      setState(() {
        examFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadExam() async {
    if (examFile == null) {
      return CoreUtils.showSnackBar(context, 'Please pick an exam to upload');
    }
    if (formKey.currentState!.validate()) {
      final json = examFile!.readAsStringSync();
      final jsonMap = jsonDecode(json) as DataMap;
      final exam = ExamModel.fromUploadMap(jsonMap)
          .copyWith(courseId: courseNotifier.value!.id);
      await context.read<ExamCubit>().uploadExam(exam);
    }
  }

  bool showingDialog = false;

  @override
  void dispose() {
    courseController.dispose();
    courseNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
        onNotificationSent: () {
          Navigator.of(context).pop();
        },
        child: BlocListener<ExamCubit, ExamState>(
            listener: (_, state) {
              if (showingDialog == true) {
                Navigator.pop(context);
                showingDialog = false;
              }
              if (state is UploadingExam) {
                CoreUtils.showLoadingDialog(context);
                showingDialog = true;
              } else if (state is ExamError) {
                CoreUtils.showSnackBar(context, state.message);
              } else if (state is ExamUploaded) {
                CoreUtils.showSnackBar(context, 'Exam uploaded successfully');
                CoreUtils.sendNotification(
                  context,
                  title: 'New ${courseNotifier.value!.title} exam',
                  body: 'A new exam has been added for '
                      '${courseNotifier.value!.title}',
                  category: ENotification.TEST,
                );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Add Exam'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: CoursePicker(
                            controller: courseController,
                            notifier: courseNotifier,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (examFile != null) ...[
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: ListTile(
                              leading: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Image.asset(MediaRes.json),
                              ),
                              title: Text(examFile!.path.split('/').last),
                              trailing: IconButton(
                                onPressed: () => setState(() {
                                  examFile = null;
                                }),
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: pickExamFile,
                              child: Text(
                                examFile == null
                                    ? 'Select Exam File'
                                    : 'Replace Exam File',
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: uploadExam,
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
