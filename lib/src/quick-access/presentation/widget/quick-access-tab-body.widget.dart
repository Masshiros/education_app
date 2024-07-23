
import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/not-found-text.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam-cubit.dart';
import 'package:education_app/src/course/presentation/cubit/course-cubit.dart';
import 'package:education_app/src/quick-access/presentation/providers/quick-access.provider.dart';
import 'package:education_app/src/quick-access/presentation/widget/document-and-exam-body.widget.dart';
import 'package:education_app/src/quick-access/presentation/widget/exam-history-body.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class QuickAccessTabBody extends StatefulWidget {
  const QuickAccessTabBody({super.key});

  @override
  State<QuickAccessTabBody> createState() => _QuickAccessTabBodyState();
}

class _QuickAccessTabBodyState extends State<QuickAccessTabBody> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if ((state is CoursesLoaded && state.courses.isEmpty) ||
            state is CourseError) {
          return const NotFoundText(
            'No courses found\nPlease contact admin or if you are admin, '
            'add courses',
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );
          return Consumer<QuickAccessProvider>(
            builder: (_, controller, __) {
              switch (controller.currentIndex) {
                case 0:
                case 1:
                  return DocumentAndExamBody(
                    courses: courses,
                    index: controller.currentIndex,
                  );
                default:
                  return BlocProvider(
                    create: (_) => getIt<ExamCubit>(),
                    child: const ExamHistoryBody(),
                  );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
