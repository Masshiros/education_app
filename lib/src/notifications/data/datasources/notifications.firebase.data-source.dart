import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource-utils.dart';
import 'package:education_app/src/notifications/data/datasources/notification.data-source.dart';
import 'package:education_app/src/notifications/data/models/notification,models.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationFirebaseDataSource implements NotificationDataSource{
  const NotificationFirebaseDataSource({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  
  @override
  Future<void> clear(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final query = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications');
      return _deleteNotificationsByQuery(query);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      DataSourceUtils.authorizeUser(_auth);
      final notificationsStream = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => NotificationModel.fromMap(doc.data()))
                .toList(),
          );
      return notificationsStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        }
        throw ServerException(message: error.toString(), statusCode: '505');
      });
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } on ServerException catch (e) {
      return Stream.error(e);
    } catch (e) {
      return Stream.error(
        ServerException(message: e.toString(), statusCode: '505'),
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'seen': true});
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> sendNotification(Notification notification) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      // add notification to every user's notification collection
      final users = await _firestore.collection('users').get();

      if (users.docs.length > 500) {
        for (var i = 0; i < users.docs.length; i += 500) {
          // 1400
          final batch = _firestore.batch();
          final end = i + 500;
          final usersBatch = users.docs
              .sublist(i, end > users.docs.length ? users.docs.length : end);
          for (final user in usersBatch) {
            final newNotificationRef =
                user.reference.collection('notifications').doc();
            batch.set(
              newNotificationRef,
              (notification as NotificationModel)
                  .copyWith(id: newNotificationRef.id)
                  .toMap(),
            );
          }
          await batch.commit();
        }
      } else {
        final batch = _firestore.batch();
        for (final user in users.docs) {
          final newNotificationRef =
              user.reference.collection('notifications').doc();
          batch.set(
            newNotificationRef,
            (notification as NotificationModel)
                .copyWith(id: newNotificationRef.id)
                .toMap(),
          );
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> _deleteNotificationsByQuery(Query query) async {
    final notifications = await query.get();
    if (notifications.docs.length > 500) {
      for (var i = 0; i < notifications.docs.length; i += 500) {
        final batch = _firestore.batch();
        final end = i + 500;
        final notificationsBatch = notifications.docs.sublist(
          i,
          end > notifications.docs.length ? notifications.docs.length : end,
        );
        for (final notification in notificationsBatch) {
          batch.delete(notification.reference);
        }
        await batch.commit();
      }
    } else {
      final batch = _firestore.batch();
      for (final notification in notifications.docs) {
        batch.delete(notification.reference);
      }
      await batch.commit();
    }
  }
}