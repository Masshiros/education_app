import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class GetExamsUseCase extends UsecaseWithParams<List<Exam>, String> {
  const GetExamsUseCase(this._repo);
  final IExamRepository _repo;

  @override
  ResultFuture<List<Exam>> call(params) async => _repo.getExams(params);
}
