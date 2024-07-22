import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam-cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/provider/exam.provider.dart';
import 'package:education_app/src/course/features/exams/presentation/widgets/exam-navigation.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});
  static const routeName = '/exam';

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool showingLoader = false;
  late ExamProvider examProvider;

  Future<void> submitExam() async {
    if (!examProvider.isTimeUp) {
      examProvider.stopTimer();
      final isMinutesLeft = examProvider.remainingTimeInSeconds > 60;
      final isHoursLeft = examProvider.remainingTimeInSeconds > 3600;
      final timeLeftText = isHoursLeft
          ? 'hours'
          : isMinutesLeft
              ? 'minutes'
              : 'seconds';

      final endExam = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Submit Exam?'),
            content: Text(
              'You have ${examProvider.remainingTime} $timeLeftText left.\n'
              'Are you sure you want to submit?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colours.redColour),
                ),
              ),
            ],
          );
        },
      );
      if (endExam ?? false) {
        return collectAndSend();
      } else {
        examProvider.startTimer();
        return;
      }
    }
    collectAndSend();
  }

  void collectAndSend() {
    final exam = examProvider.userExam;
    context.read<ExamCubit>().submitExam(exam);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    examProvider = context.read<ExamProvider>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      examProvider.addListener(() {
        if (examProvider.isTimeUp) submitExam();
      });
    });
  }

  @override
  void dispose() {
    examProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamProvider>(
      builder: (_, controller, __) {
        return BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (showingLoader) {
              Navigator.pop(context);
              showingLoader = false;
            }
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is SubmittingExam) {
              CoreUtils.showLoadingDialog(context);
              showingLoader = true;
            } else if (state is ExamSubmitted) {
              CoreUtils.showSnackBar(context, 'Exam Submitted');
              Navigator.pop(context);
            }
          },
          builder: (_, state) => WillPopScope(
            onWillPop: () async {
              if (state is SubmittingExam) return false;
              if (controller.isTimeUp) return true;
              final result = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text('Exit Exam'),
                    content:
                        const Text('Are you sure you want to Exit the exam'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Exit exam'),
                      ),
                    ],
                  );
                },
              );
              return result ?? false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(MediaRes.examTimeRed, height: 30, width: 30),
                    const SizedBox(width: 10),
                    Text(
                      controller.remainingTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colours.redColour,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: submitExam,
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              'Question ${controller.currentIndex + 1}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFF666E7A),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color(0xFFC4C4C4),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: controller.exam.imageUrl == null
                                    ? Image.asset(
                                        MediaRes.test,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller.exam.imageUrl!,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              controller.currentQuestion.questionText,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.currentQuestion.choices.length,
                              itemBuilder: (_, index) {
                                final choice =
                                    controller.currentQuestion.choices[index];
                                return RadioListTile(
                                  value: choice.identifier,
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: controller.userAnswer?.userChoice,
                                  title: Text(
                                    '${choice.identifier}. '
                                    '${choice.choiceAnswer}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.answer(choice);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const ExamNavigation(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
