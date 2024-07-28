import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/src/chat/data/models/message.models.dart';
import 'package:education_app/src/chat/presentation/cubit/chat-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({required this.groupId, super.key});

  final String groupId;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Message',
          hintStyle: const TextStyle(
            color: Color(0xFF9FA5BB),
          ),
          filled: true,
          fillColor: Colours.chatFieldColour,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Transform.scale(
            scale: .75,
            child: IconButton.filled(
              padding: EdgeInsets.zero,
              icon: const Icon(IconlyLight.send, color: Colors.white),
              onPressed: () {
                final message = controller.text.trim();
                if (message.isEmpty) return;
                controller.clear();
                focusNode.unfocus();
                context.read<ChatCubit>().sendMessage(
                      MessageModel.empty().copyWith(
                        message: message,
                        senderId: context.currentUser!.uid,
                        groupId: widget.groupId,
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
