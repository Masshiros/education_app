import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/domain/usecases/get-groups.usecase.dart';
import 'package:education_app/src/chat/domain/usecases/get-messages.usecase.dart';
import 'package:education_app/src/chat/domain/usecases/get-user-by-id.usecase.dart';
import 'package:education_app/src/chat/domain/usecases/join-group.usecase.dart';
import 'package:education_app/src/chat/domain/usecases/leave-group.usecase.dart';
import 'package:education_app/src/chat/domain/usecases/send-message.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat-state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required GetGroupsUseCase getGroups,
    required GetMessagesUseCase getMessages,
    required GetUserByIdUseCase getUserById,
    required JoinGroupUseCase joinGroup,
    required LeaveGroupUseCase leaveGroup,
    required SendMessageUseCase sendMessage,
  })  : _getGroups = getGroups,
        _getMessages = getMessages,
        _getUserById = getUserById,
        _joinGroup = joinGroup,
        _leaveGroup = leaveGroup,
        _sendMessage = sendMessage,
        super(const ChatInitial());

  final GetGroupsUseCase _getGroups;
  final GetMessagesUseCase _getMessages;
  final GetUserByIdUseCase _getUserById;
  final JoinGroupUseCase _joinGroup;
  final LeaveGroupUseCase _leaveGroup;
  final SendMessageUseCase _sendMessage;

  Future<void> sendMessage(Message message) async {
    emit(const SendingMessage());
    final result = await _sendMessage(message);
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const MessageSent()),
    );
  }

  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const JoiningGroup());
    final result = await _joinGroup(
      JoinGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const JoinedGroup()),
    );
  }

  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const LeavingGroup());
    final result = await _leaveGroup(
      LeaveGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const LeftGroup()),
    );
  }

  Future<void> getUser(String userId) async {
    emit(const GettingUser());
    final result = await _getUserById(userId);

    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (user) => emit(UserFound(user)),
    );
  }

  void getGroups() {
    emit(const LoadingGroups());

    StreamSubscription<Either<Failure, List<Group>>>? subscription;

    subscription = _getGroups().listen(
      (result) {
        result.fold(
          (failure) => emit(ChatError(failure.errorMessage)),
          (groups) => emit(GroupsLoaded(groups)),
        );
      },
      onError: (dynamic error) {
        emit(ChatError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }

  void getMessages(String groupId) {
    emit(const LoadingMessages());

    StreamSubscription<Either<Failure, List<Message>>>? subscription;

    subscription = _getMessages(groupId).listen(
      (result) {
        result.fold(
          (failure) => emit(ChatError(failure.errorMessage)),
          (messages) => emit(MessagesLoaded(messages)),
        );
      },
      onError: (dynamic error) {
        emit(ChatError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }
}
