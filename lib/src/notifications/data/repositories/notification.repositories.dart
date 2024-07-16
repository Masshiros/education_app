import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/data/datasources/notification.data-source.dart';
import 'package:education_app/src/notifications/data/models/notification.models.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repositories/notifications.repositories.dart';
import 'package:flutter/foundation.dart';

class NotificationRepository implements INotificationRepository {
  const NotificationRepository(this._dataSource);
  final NotificationDataSource _dataSource;

  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _dataSource.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> clearAll() async {
    try {
      await _dataSource.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<Notification>> getNotifications() {
    return _dataSource.getNotifications().transform(StreamTransformer<
                List<NotificationModel>,
                Either<Failure, List<Notification>>>.fromHandlers(
            handleData: (notifications, sink) {
          sink.add(Right(notifications));
        }, handleError: (error, stackTrace, sink) {
          debugPrint(stackTrace.toString());
          if (error is ServerException) {
            sink.add(Left(ServerFailure.fromException(error)));
          } else {
            sink.add(Left(
                ServerFailure(message: error.toString(), statusCode: 505)));
          }
        }));
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _dataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendNotification(Notification notification) async {
    try {
      await _dataSource.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
