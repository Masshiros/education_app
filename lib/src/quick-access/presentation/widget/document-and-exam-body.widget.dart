
import 'package:education_app/core/common/widgets/course-tile.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam-cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/views/course-exams.view.dart';
import 'package:education_app/src/course/features/resources/presentation/cubit/resource-cubit.dart';
import 'package:education_app/src/course/features/resources/presentation/views/course-resources.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentAndExamBody extends StatelessWidget {
  const DocumentAndExamBody({
    required this.courses,
    required this.index,
    super.key,
  });

  final List<Course> courses;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20).copyWith(top: 0),
      children: [
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 40,
            runAlignment: WrapAlignment.spaceEvenly,
            children: courses.map((course) {
              return CourseTile(
                course: course,
                onTap: () {
                  context.push(
                    index == 0
                        ? BlocProvider(
                            create: (_) => getIt<ResourceCubit>(),
                            child: CourseResourcesView(course),
                          )
                        : BlocProvider(
                            create: (_) => getIt<ExamCubit>(),
                            child: CourseExamsView(course),
                          ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
