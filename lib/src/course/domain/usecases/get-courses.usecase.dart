import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';

class GetCoursesUseCase extends UsecaseWithoutParams<List<Course>> {
  const GetCoursesUseCase(this._repo);
  final ICourseRepository _repo;
  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();
}
