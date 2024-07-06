import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();
  static Stream<LocalUserModel> get userDataStream => getIt<FirebaseFirestore>()
      .collection("users")
      .doc(getIt<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
