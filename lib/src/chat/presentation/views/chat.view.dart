import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/presentation/cubit/chat-cubit.dart';
import 'package:education_app/src/chat/presentation/widgets/chat-app-bar.widget.dart';
import 'package:education_app/src/chat/presentation/widgets/chat-input-field.widget.dart';
import 'package:education_app/src/chat/presentation/widgets/message-bubble.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({required this.group, super.key});

  final Group group;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool showingDialog = false;

  List<Message> messages = [];
  bool showInputField = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(group: widget.group),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, state) {
          if (showingDialog) {
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is ChatError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is LeavingGroup) {
            showingDialog = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is LeftGroup) {
            context.pop();
          } else if (state is MessagesLoaded) {
            setState(() {
              messages = state.messages;
              showInputField = true;
            });
          }
        },
        builder: (context, state) {
          if (state is LoadingMessages) {
            return const LoadingView();
          } else if (state is MessagesLoaded ||
              showInputField ||
              messages.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (_, index) {
                      final message = messages[index];
                      final previousMessage =
                          index > 0 ? messages[index - 1] : null;

                      final showSenderInfo = previousMessage == null ||
                          previousMessage.senderId != message.senderId;
                      return BlocProvider(
                        create: (_) => getIt<ChatCubit>(),
                        child: MessageBubble(
                          key: ValueKey(message.id),
                          message,
                          showSenderInfo: showSenderInfo,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                BlocProvider(
                  create: (_) => getIt<ChatCubit>(),
                  child: ChatInputField(groupId: widget.group.id),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
