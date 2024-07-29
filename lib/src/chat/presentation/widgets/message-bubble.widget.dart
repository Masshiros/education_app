import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/presentation/cubit/chat-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(this.message, {required this.showSenderInfo, super.key});

  final Message message;
  final bool showSenderInfo;
  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  LocalUser? user;

  late bool isCurrentUser;

  @override
  void initState() {
    if (widget.message.senderId == context.currentUser!.uid) {
      user = context.currentUser;
      isCurrentUser = true;
    } else {
      isCurrentUser = false;
      context.read<ChatCubit>().getUser(widget.message.senderId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (_, state) {
        if (state is UserFound && user == null) {
          setState(() {
            user = state.user;
          });
        }
      },
      child: Container(
        key: widget.key,
        constraints: BoxConstraints(maxWidth: context.width - 45),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (widget.showSenderInfo && !isCurrentUser)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      user == null || (user!.profilePic == null)
                          ? kDefaultAvatar
                          : user!.profilePic!,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user == null ? 'Unknown User' : user!.fullName,
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.only(top: 4, left: isCurrentUser ? 0 : 20),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isCurrentUser
                    ? Colours.currentUserChatBubbleColour
                    : Colours.otherUserChatBubbleColour,
              ),
              child: Text(
                widget.message.message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
