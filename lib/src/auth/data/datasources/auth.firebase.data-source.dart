import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/src/auth/data/datasources/auth.data-source.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseDataSource implements AuthDataSource{
  const FirebaseDataSource({
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
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String fullName, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required EUpdateUserAction action, required userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
  
}