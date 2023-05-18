// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lilac_flutter_machine_test/services/extensions.dart';

class ProfileServices {
  final userCollec = FirebaseFirestore.instance.collection('User data table');
  Future<DocumentSnapshot?> getUserData() async {
    DocumentSnapshot? snapshot;
    try {
      snapshot = await userCollec.doc(await getUserId()).get();
    } catch (e) {
      print(e);
    }
    return snapshot;
  }

  Future<bool> updateUserData(Map<String, dynamic> patchBody) async {
    try {
      await userCollec.doc(await getUserId()).update(patchBody);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
