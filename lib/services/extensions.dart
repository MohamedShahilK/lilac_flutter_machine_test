import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserId() async {
  final User? userData = FirebaseAuth.instance.currentUser;
  if (userData == null) {
    return '';
  } else {
    return userData.uid;
  }
}

DateTime convertToDateTime(var inputData) {
  if (inputData is Timestamp) {
    return inputData.toDate();
  } else if (inputData is DateTime) {
    return inputData;
  } else {
    return DateTime.now();
  }
}
