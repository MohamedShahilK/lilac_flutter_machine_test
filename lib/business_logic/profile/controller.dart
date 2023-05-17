import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/profile/state.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  // LogOut
  Future performLogOut() async {
    final User? userData = FirebaseAuth.instance.currentUser;
    if (userData != null) { 
      await FirebaseAuth.instance.signOut();
      return true;
    } else {
      return false;
    }
  }
}
