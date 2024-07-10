import 'package:education_app/core/common/providers/user.provider.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/course/presentation/cubit/course-cubit.dart';
import 'package:education_app/src/course/presentation/widgets/add-course-sheet.widget.dart';
import 'package:education_app/src/profile/presentation/widgets/admin-button.dart';
import 'package:education_app/src/profile/presentation/widgets/user-info-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      final user = provider.user;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: UserInfoCard(
                  infoThemeColor: Colours.physicsTileColour,
                  infoIcon: const Icon(
                    IconlyLight.document,
                    size: 24,
                    color: Color(0xFF767DFF),
                  ),
                  infoTitle: 'Courses',
                  infoValue: user!.enrolledCourseIds.length.toString(),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: UserInfoCard(
                  infoThemeColor: Colours.languageTileColour,
                  infoIcon: Image.asset(
                    MediaRes.scoreboard,
                    height: 24,
                    width: 24,
                  ),
                  infoTitle: 'Score',
                  infoValue: user.points.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: UserInfoCard(
                  infoThemeColor: Colours.biologyTileColour,
                  infoIcon: const Icon(
                    IconlyLight.user,
                    color: Color(0xFF56AEFF),
                    size: 24,
                  ),
                  infoTitle: 'Followers',
                  infoValue: user.followers.length.toString(),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: UserInfoCard(
                  infoThemeColor: Colours.chemistryTileColour,
                  infoIcon: const Icon(
                    IconlyLight.user,
                    color: Color(0xFFFF84AA),
                    size: 24,
                  ),
                  infoTitle: 'Following',
                  infoValue: user.following.length.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          if (context.currentUser!.isAdmin) ...[
            AdminButton(
              label: 'Add Course',
              icon: IconlyLight.paper_upload,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  showDragHandle: true,
                  elevation: 0,
                  useSafeArea: true,
                  builder: (_) => BlocProvider(
                    create: (_) => getIt<CourseCubit>(),
                    child: const AddCourseSheet(),
                  ),
                );
              },
            )
          ]
        ],
      );
    });
  }
}
