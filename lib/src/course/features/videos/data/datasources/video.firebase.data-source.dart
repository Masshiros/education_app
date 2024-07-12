import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> addVideo(Video video) {
    // TODO: implement addVideo
    throw UnimplementedError();
  }

  @override
  Future<List<VideoModel>> getVideos(String courseId) {
    // TODO: implement getVideos
    throw UnimplementedError();
  }
}
