import 'package:education_app/src/course/features/exams/data/models/exam-question.models.dart';
import 'package:education_app/src/course/features/exams/data/models/exam.models.dart';
import 'package:education_app/src/course/features/exams/data/models/user-exam.models.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';

abstract class ExamDataSource {
  Future<List<ExamModel>> getExams(String courseId);

  Future<void> uploadExam(Exam exam);

  Future<List<ExamQuestionModel>> getExamQuestions(Exam exam);

  Future<void> updateExam(Exam exam);

  Future<void> submitExam(UserExam exam);

  Future<List<UserExamModel>> getUserExams();

  Future<List<UserExamModel>> getUserCourseExams(String courseId);
}
