import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';

class AddCourseUseCase extends UsecaseWithParams<void, Course> {
  const AddCourseUseCase(this._repo);
  final ICourseRepository _repo;
  @override
  ResultFuture<void> call(Course params) => _repo.addCourse(params);
}
