import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class GetUserCourseExamsUseCase
    extends UsecaseWithParams<List<UserExam>, String> {
  const GetUserCourseExamsUseCase(this._repo);
  final IExamRepository _repo;

  @override
  ResultFuture<List<UserExam>> call(String params) async =>
      _repo.getUserCourseExams(params);
}
