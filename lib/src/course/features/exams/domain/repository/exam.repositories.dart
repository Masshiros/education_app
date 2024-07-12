import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam-question.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';

abstract interface class IExamRepository {
  const IExamRepository();
  ResultFuture<List<Exam>> getExams(String courseId);
  ResultFuture<List<ExamQuestion>> getExamQuestions(Exam exam);
  ResultFuture<void> uploadExam(Exam exam);
  ResultFuture<void> updateExam(Exam exam);
  ResultFuture<void> submitExam(UserExam userExam);
  ResultFuture<List<UserExam>> getUserExams();
  ResultFuture<List<UserExam>> getUserCourseExams(String courseId);
}
