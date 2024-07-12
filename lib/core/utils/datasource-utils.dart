
import 'package:education_app/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataSourceUtils {
  const DataSourceUtils._();

  static Future<void> authorizeUser(FirebaseAuth auth) async {
    final user = auth.currentUser;
    if (user == null) {
      throw const ServerException(
        message: 'User is not authenticated',
        statusCode: '401',
      );
    }
  }
}
