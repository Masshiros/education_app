import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/not-found-text.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';
import 'package:education_app/src/chat/presentation/cubit/chat-cubit.dart';
import 'package:education_app/src/chat/presentation/widgets/other-group-tile.widget.dart';
import 'package:education_app/src/chat/presentation/widgets/your-group-tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  List<Group> yourGroups = [];
  List<Group> otherGroups = [];

  bool showingDialog = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Chat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (_, state) {
            if (showingDialog) {
              Navigator.of(context).pop();
              showingDialog = false;
            }
            if (state is ChatError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is JoiningGroup) {
              showingDialog = true;
              CoreUtils.showLoadingDialog(context);
            } else if (state is JoinedGroup) {
              CoreUtils.showSnackBar(context, 'Joined group successfully');
            } else if (state is GroupsLoaded) {
              yourGroups = state.groups
                  .where(
                    (group) => group.members.contains(context.currentUser!.uid),
                  )
                  .toList();
              otherGroups = state.groups
                  .where(
                    (group) =>
                        !group.members.contains(context.currentUser!.uid),
                  )
                  .toList();
            }
          },
          builder: (context, state) {
            if (state is LoadingGroups) {
              return const LoadingView();
            } else if (state is GroupsLoaded && state.groups.isEmpty) {
              return const NotFoundText(
                'No groups found\nPlease contact admin or if you are admin, '
                'add courses',
              );
            } else if ((state is GroupsLoaded) ||
                (yourGroups.isNotEmpty) ||
                (otherGroups.isNotEmpty)) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (yourGroups.isNotEmpty) ...[
                    Text(
                      'Your Groups',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    ...yourGroups.map(YourGroupTile.new),
                  ],
                  if (otherGroups.isNotEmpty) ...[
                    Text(
                      'Groups',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    ...otherGroups.map(OtherGroupTile.new),
                  ],
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
