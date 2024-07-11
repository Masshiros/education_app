import 'package:education_app/core/common/widgets/course-tile.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/common/widgets/nested-back-button.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/presentation/views/course-details.view.dart';
import 'package:flutter/material.dart';

class AllCoursesView extends StatelessWidget {
  const AllCoursesView({super.key, required this.courses});
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const NestedBackButton(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: GradientBackground(
          image: MediaRes.homeGradientBackground,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'All Subjects',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 40,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: courses
                        .map(
                          (course) => CourseTile(
                            course: course,
                            onTap: () => Navigator.of(context).pushNamed(
                              //TODO(Course-details-screen): add route name here
                              CourseDetailsScreen.routeName,
                              arguments: course,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
