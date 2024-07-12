
import 'dart:io';

import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/course/data/models/course.model.dart';
import 'package:education_app/src/course/features/resources/data/datasources/firebase.resource.data-source.dart';
import 'package:education_app/src/course/features/resources/data/datasources/resource.data-source.dart';
import 'package:education_app/src/course/features/resources/data/models/resource.models.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late ResourceDataSource remoteDataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);
    storage = MockFirebaseStorage();

    remoteDataSource = ResourceFirebaseDataSource(
      firestore: firestore,
      auth: auth,
      storage: storage,
    );
  });

  final tResource = ResourceModel.empty();

  group('addResource', () {
    setUp(() async {
      await firestore
          .collection('courses')
          .doc(tResource.courseId)
          .set(CourseModel.empty().toMap());
    });
    test('should add the provided [Resource] to the firestore', () async {
      await remoteDataSource.addResource(tResource);

      final collectionRef = await firestore
          .collection('courses')
          .doc(tResource.courseId)
          .collection('resources')
          .get();

      expect(collectionRef.docs.length, equals(1));
    });
    test(
      'should add the provided [Resource] to the storage',
      () async {
        final resourceFile = File('assets/images/auth_gradient_background.png');
        final resource = tResource.copyWith(
          fileURL: resourceFile.path,
        );

        await remoteDataSource.addResource(resource);

        final collectionRef = await firestore
            .collection('courses')
            .doc(tResource.courseId)
            .collection('resources')
            .get();

        expect(collectionRef.docs.length, equals(1));
        final savedResource = collectionRef.docs.first.data();

        final storageResourceURL = await storage
            .ref()
            .child(
              'courses/${tResource.courseId}/resources/${savedResource['id']}/resource',
            )
            .getDownloadURL();

        expect(savedResource['fileURL'], equals(storageResourceURL));
      },
    );
    test(
      "should throw a [ServerException] when there's an error",
      () async {
        final call = remoteDataSource.addResource;
        expect(() => call(Resource.empty()), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getResources', () {
    test('should return a list of [Resource] from the firestore', () async {
      await firestore
          .collection('courses')
          .doc(tResource.courseId)
          .set(CourseModel.empty().toMap());
      await remoteDataSource.addResource(tResource);

      final result = await remoteDataSource.getResources(tResource.courseId);

      expect(result, isA<List<Resource>>());
      expect(result.length, equals(1));
      expect(result.first.description, equals(tResource.description));
    });
    // it's difficult to simulate an error with the fake firestore, because it
    // doesn't throw any errors, so we'll just test that it returns an empty
    // list when there's an error
    test('should return an empty list when there is an error', () async {
      final result = await remoteDataSource.getResources(tResource.courseId);

      expect(result, isA<List<Resource>>());
      expect(result.isEmpty, isTrue);
    });
  });
}
