import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class SubmitExamUseCase extends UsecaseWithParams<void, UserExam> {
  const SubmitExamUseCase(this._repo);
  final IExamRepository _repo;
  @override
  ResultFuture<void> call(UserExam params) async => _repo.submitExam(params);
}
