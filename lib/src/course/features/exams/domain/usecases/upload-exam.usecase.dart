import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class UploadExamUseCase extends UsecaseWithParams<void, Exam> {
  const UploadExamUseCase(this._repo);
  final IExamRepository _repo;
  @override
  ResultFuture call(params) async => _repo.uploadExam(params);
}
