import 'package:education_app/core/common/widgets/course-info-tile.dart';
import 'package:education_app/core/common/widgets/expandable-text.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/extensions/int.extension.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/resources/presentation/views/course-resources.view.dart';
import 'package:education_app/src/course/features/videos/presentation/views/course-videos.view.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.course});
  static const routeName = '/course-details';
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * 0.3,
                child: course.image != null
                    ? Image.network(course.image!)
                    : Image.asset(MediaRes.casualMeditation),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (course.description != null)
                    ExpandableText(context, text: course.description!),
                  if (course.numberOfMaterials > 0 ||
                      course.numberOfVideos > 0 ||
                      course.numberOfExams > 0) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Subject Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoVideo,
                        title: '${course.numberOfVideos} Video(s)',
                        subtitle: 'Watch our tutorial '
                            'videos for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          CourseVideosView.routeName,
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoExam,
                        title: '${course.numberOfExams} Exam(s)',
                        subtitle: 'Take our exams for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoMaterial,
                        title: '${course.numberOfMaterials} Material(s)',
                        subtitle: 'Access to '
                            '${course.numberOfMaterials.estimate} materials '
                            'for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          CourseResourcesView.routeName,
                          arguments: course,
                        ),
                      ),
                    ],
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
