import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/src/course/data/datasources/course.data-source.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseFirebaseDataSource implements CourseDataSource{
  const CourseFirebaseDataSource({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;
  @override
  Future<void> addCourse(Course course) {
    // TODO: implement addCourse
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
  
}