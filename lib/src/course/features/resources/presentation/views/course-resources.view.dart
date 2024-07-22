import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/common/widgets/nested-back-button.dart';
import 'package:education_app/core/common/widgets/not-found-text.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/exams/presentation/providers/resource.provider.dart';
import 'package:education_app/src/course/features/resources/presentation/cubit/resource-cubit.dart';
import 'package:education_app/src/course/features/resources/presentation/widgets/resource-tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CourseResourcesView extends StatefulWidget {
  const CourseResourcesView(this.course, {super.key});
  static const routeName = '/course-materials';

  final Course course;

  @override
  State<CourseResourcesView> createState() => _CourseResourcesViewState();
}

class _CourseResourcesViewState extends State<CourseResourcesView> {
  void getMaterials() {
    context.read<ResourceCubit>().getResources(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.course.title} Materials'),
        leading: const NestedBackButton(),
      ),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<ResourceCubit, ResourceState>(
          listener: (_, state) {
            if (state is ResourceError) {
              CoreUtils.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingResources) {
              return const LoadingView();
            } else if ((state is ResourcesLoaded && state.resources.isEmpty) ||
                state is ResourceError) {
              return NotFoundText(
                'No videos found for ${widget.course.title}',
              );
            } else if (state is ResourcesLoaded) {
              final resources = state.resources
                ..sort(
                  (a, b) => b.uploadDate.compareTo(a.uploadDate),
                );
              return SafeArea(
                child: ListView.separated(
                  itemCount: resources.length,
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFFE6E8EC),
                  ),
                  itemBuilder: (_, index) {
                    return ChangeNotifierProvider(
                      create: (_) =>
                          getIt<ResourceProvider>()..init(resources[index]),
                      child: const ResourceTile(),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
