import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource-utils.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video.data-source.dart';
import 'package:education_app/src/course/features/videos/data/models/video.models.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoFirebaseDataSource extends VideoDataSource {
  const VideoFirebaseDataSource({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  @override
  Future<void> addVideo(Video video) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final videoRef = _firestore
          .collection('courses')
          .doc(video.courseId)
          .collection('videos')
          .doc();

      var videoModel = (video as VideoModel).copyWith(id: videoRef.id);
      if (videoModel.thumbnailIsFile) {
        final thumbnailFileRef = _storage.ref().child(
              'courses/${videoModel.courseId}/videos/${videoRef.id}/thumbnail',
            );
        await thumbnailFileRef
            .putFile(File(videoModel.thumbnail!))
            .then((value) async {
          final url = await value.ref.getDownloadURL();
          videoModel = videoModel.copyWith(thumbnail: url);
        });
      }
      await videoRef.set(videoModel.toMap());

      await _firestore.collection('courses').doc(video.courseId).update({
        'numberOfVideos': FieldValue.increment(1),
      });
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
  Future<List<VideoModel>> getVideos(String courseId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final videos = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('videos')
          .get();

      return videos.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
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
}
