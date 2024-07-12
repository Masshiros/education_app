import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam-question.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class GetExamQuestionsUseCase
    extends UsecaseWithParams<List<ExamQuestion>, Exam> {
  const GetExamQuestionsUseCase(this._repo);
  final IExamRepository _repo;

  @override
  ResultFuture<List<ExamQuestion>> call(Exam params) async =>
      _repo.getExamQuestions(params);
}
