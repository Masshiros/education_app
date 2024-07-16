import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/usecases/clear-all.usecase.dart';
import 'package:education_app/src/notifications/domain/usecases/clear.usecase.dart';
import 'package:education_app/src/notifications/domain/usecases/get-notifications.usecase.dart';
import 'package:education_app/src/notifications/domain/usecases/mark-as-read.usecase.dart';
import 'package:education_app/src/notifications/domain/usecases/send-notifcation.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notifications-state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({
    required ClearUseCase clear,
    required ClearAllUseCase clearAll,
    required GetNotificationsUseCase getNotifications,
    required MarkAsReadUseCase markAsRead,
    required SendNotificationUseCase sendNotification,
  })  : _clear = clear,
        _clearAll = clearAll,
        _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _sendNotification = sendNotification,
        super(const NotificationsInitial());
  final ClearUseCase _clear;
  final ClearAllUseCase _clearAll;
  final GetNotificationsUseCase _getNotifications;
  final MarkAsReadUseCase _markAsRead;
  final SendNotificationUseCase _sendNotification;
  Future<void> clear(String notificationId) async {
    emit(const ClearingNotifications());
    final result = await _clear(notificationId);
    result.fold(
      (failure) {
        print(failure);
        emit(NotificationError(failure.errorMessage));
      },
      (_) {
        print('Cleared');
        emit(const NotificationsCleared());
      },
    );
  }

  Future<void> clearAll() async {
    emit(const ClearingNotifications());
    final result = await _clearAll();
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationsCleared()),
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _markAsRead(notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationsInitial()),
    );
  }

  Future<void> sendNotification(Notification notification) async {
    emit(const SendingNotification());
    final result = await _sendNotification(notification);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationSent()),
    );
  }

  void getNotifications() {
    emit(const GettingNotifications());
    StreamSubscription<Either<Failure, List<Notification>>>? subscription;

    subscription = _getNotifications().listen(
      /*onData:*/
      (result) {
        result.fold(
          (failure) {
            emit(NotificationError(failure.errorMessage));
            subscription?.cancel();
          },
          (notifications) => emit(NotificationsLoaded(notifications)),
        );
      },
      onError: (dynamic error) {
        emit(NotificationError(error.toString()));
        subscription?.cancel();
      },
      onDone: () {
        subscription?.cancel();
      },
    );
  }
}
