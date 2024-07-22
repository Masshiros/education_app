import 'package:education_app/core/common/widgets/course-info-tile.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/common/widgets/rounded-button.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/extensions/int.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/features/exams/data/models/exam.models.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView(this.exam, {super.key});
  static const routeName = '/exam-details';
  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  late Exam completeExam;
  
  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    completeExam = widget.exam;
    super.initState();
    getQuestions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.exam.title)),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is ExamQuestionsLoaded) {
              completeExam = (completeExam as ExamModel).copyWith(
                questions: state.questions,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colours.physicsTileColour,
                              ),
                              child: Center(
                                child: completeExam.imageUrl != null
                                    ? Image.network(
                                        completeExam.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.test,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            completeExam.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            completeExam.description,
                            style: const TextStyle(
                              color: Colours.neutralTextColour,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CourseInfoTile(
                            image: MediaRes.examTime,
                            title:
                                '${completeExam.timeLimit.displayDurationLong}'
                                ' for the test.',
                            subtitle: 'Complete the test in '
                                '${completeExam.timeLimit.displayDurationLong}',
                          ),
                          if (state is ExamQuestionsLoaded) ...[
                            const SizedBox(height: 10),
                            CourseInfoTile(
                              image: MediaRes.examQuestions,
                              title: '${completeExam.questions?.length} '
                                  'Questions',
                              subtitle: 'This test consists of '
                                  '${completeExam.questions?.length} questions',
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state is GettingExamQuestions)
                      const Center(child: LinearProgressIndicator())
                    else if (state is ExamQuestionsLoaded)
                      RoundedButton(
                        label: 'Start Exam',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/',
                            arguments: completeExam,
                          );
                        },
                      )
                    else
                      Text(
                        'No Questions for this exam',
                        style: context.theme.textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
