
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';
import 'package:education_app/src/quick-access/presentation/views/exam-history-detail.view.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ExamHistoryTile extends StatelessWidget {
  const ExamHistoryTile(this.exam, {
    super.key,
    this.navigateToDetails = true,
  });

  final UserExam exam;
  final bool navigateToDetails;

  @override
  Widget build(BuildContext context) {
    final answeredQuestionsPercentage =
        exam.answers.length / exam.totalQuestions;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: navigateToDetails
          ? () => Navigator.of(context).pushNamed(
                ExamHistoryDetailsScreen.routeName,
                arguments: exam,
              )
          : null,
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: Colours.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: exam.examImageUrl == null
                ? Image.asset(MediaRes.test)
                : Image.network(exam.examImageUrl!),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam.examTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You have completed',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: '${exam.answers.length}/${exam.totalQuestions} ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: answeredQuestionsPercentage < .5
                          ? Colours.redColour
                          : Colours.greenColour,
                    ),
                    children: const [
                      TextSpan(
                        text: 'questions',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularStepProgressIndicator(
            totalSteps: exam.totalQuestions,
            currentStep: exam.answers.length,
            selectedColor: answeredQuestionsPercentage < .5
                ? Colours.redColour
                : Colours.greenColour,
            padding: 0,
            width: 60,
            height: 60,
            child: Center(
              child: Text(
                '${(answeredQuestionsPercentage * 100).toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: answeredQuestionsPercentage < .5
                      ? Colours.redColour
                      : Colours.greenColour,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
