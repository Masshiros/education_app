import 'package:education_app/src/course/features/exams/presentation/provider/exam.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamNavigation extends StatelessWidget {
  const ExamNavigation({super.key});

 @override
  Widget build(BuildContext context) {
    return Consumer<ExamProvider>(
      builder: (_, controller, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Question ${controller.currentIndex + 1} of'
              ' ${controller.totalQuestions}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF666E7A)),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFE8E8E8),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: Offset(2, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: controller.previousQuestion,
                    icon: Icon(
                      Icons.arrow_back,
                      color: controller.currentIndex == 0
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  Container(
                    color: const Color(0xFFE4E6EA),
                    width: 1,
                    height: 24,
                  ),
                  IconButton(
                    onPressed: controller.nextQuestion,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: controller.currentIndex == controller
                          .totalQuestions - 1
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}