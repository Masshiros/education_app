import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource-utils.dart';
import 'package:education_app/src/course/features/resources/data/datasources/resource.data-source.dart';
import 'package:education_app/src/course/features/resources/data/models/resource.models.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ResourceFirebaseDataSource implements ResourceDataSource {
  const ResourceFirebaseDataSource({
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
  Future<void> addResource(Resource resource) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final resourceRef = _firestore
          .collection('courses')
          .doc(resource.courseId)
          .collection('resources')
          .doc();
      var resourceModel =
          (resource as ResourceModel).copyWith(id: resourceRef.id);
      if (resourceModel.isFile) {
        final resourceFileRef = _storage.ref().child(
              'courses/${resourceModel.courseId}/resources/${resourceModel.id}/resource',
            );
        await resourceFileRef
            .putFile(File(resourceModel.fileURL))
            .then((value) async {
          final url = await value.ref.getDownloadURL();
          resourceModel = resourceModel.copyWith(fileURL: url);
        });
      }
      await resourceRef.set(resourceModel.toMap());

      await _firestore.collection('courses').doc(resource.courseId).update({
        'numberOfresources': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<ResourceModel>> getResources(String courseId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      final resourcesRef = _firestore
          .collection('courses')
          .doc(courseId)
          .collection('resources');
      final resources = await resourcesRef.get();
      return resources.docs
          .map((e) => ResourceModel.fromMap(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
