import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/chat/data/datasources/chat.data-sources.dart';
import 'package:education_app/src/chat/data/models/group.models.dart';
import 'package:education_app/src/chat/data/models/message.models.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';

class ChatRepository implements IChatRepositories {
  const ChatRepository(this._dataSource);
  final ChatDataSource _dataSource;

  @override
  ResultStream<List<Group>> getGroups() {
    return _dataSource.getGroups().transform(StreamTransformer<List<GroupModel>,
                Either<Failure, List<Group>>>.fromHandlers(
            handleError: (error, stackTrace, sink) {
          if (error is ServerException) {
            sink.add(Left(ServerFailure.fromException(error)));
          } else {
            sink.add(Left(
                ServerFailure(message: error.toString(), statusCode: '505')));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  ResultStream<List<Message>> getMessages(String groupId) {
    return _dataSource.getMessages(groupId).transform(StreamTransformer<
                List<MessageModel>,
                Either<Failure, List<Message>>>.fromHandlers(
            handleError: (error, stackTrace, sink) {
          if (error is ServerException) {
            sink.add(Left(ServerFailure.fromException(error)));
          } else {
            sink.add(Left(
                ServerFailure(message: error.toString(), statusCode: '505')));
          }
        }, handleData: (data, sink) {
          sink.add(Right(data));
        }));
  }

  @override
  ResultFuture<LocalUser> getUserById(String userId) async {
    try {
      return Right(await _dataSource.getUserById(userId));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> joinGroup(
      {required String groupId, required String userId}) async {
    try {
      await _dataSource.joinGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> leaveGroup(
      {required String groupId, required String userId}) async {
    try {
      await _dataSource.leaveGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendMessage(Message message) async {
    try {
      await _dataSource.sendMessage(message);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
