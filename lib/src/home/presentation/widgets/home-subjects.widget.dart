import 'package:education_app/core/common/widgets/course-tile.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/presentation/views/all-courses.view.dart';
import 'package:education_app/src/home/presentation/widgets/section-header.widget.dart';
import 'package:flutter/material.dart';

class HomeSubjects extends StatelessWidget {
  const HomeSubjects({super.key, required this.courses});
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
            title: 'Courses',
            seeAll: courses.length > 4,
            onSeeAll: () => context.push(AllCoursesView(
                  courses: courses,
                ))),
        const Text(
          'Explore our courses',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colours.neutralTextColour,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: courses
              .take(4)
              .map((course) => CourseTile(
                    course: course,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/',
                      arguments: course,
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
