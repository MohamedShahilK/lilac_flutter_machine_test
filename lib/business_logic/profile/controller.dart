// ignore_for_file: unnecessary_overrides, duplicate_ignore, avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lilac_flutter_machine_test/business_logic/profile/services.dart';
import 'package:lilac_flutter_machine_test/business_logic/profile/state.dart';
import 'package:lilac_flutter_machine_test/model/user_login_model.dart';
import 'package:lilac_flutter_machine_test/services/extensions.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';

class ProfileController extends GetxController {
  final state = ProfileState();
  final services = ProfileServices();

  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  var listener;

  File? photo;
  final ImagePicker _picker = ImagePicker();

  // ignore: unnecessary_overrides
  @override
  void onInit() {
    super.onInit();
    // getUserData();
    // var params = Get.parameters;
    // state.isProfilePage.value =
    //     params['isProfilePage'] == 'true' ? true : false;
  }

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }

  // Ger User Data
  Future getUserData() async {
    // print('111111111111111111111');
    UserLoginModel? userLoginModel;
    final docSnap = await services.getUserData();
    if (docSnap != null) {
      final Map<String, dynamic>? map = docSnap.data() as Map<String, dynamic>?;
      if (map != null) {
        userLoginModel = UserLoginModel.fromFirestore(docSnap);
      }
    }

    if (userLoginModel != null) {
      state.userName.value = userLoginModel.userName;
      state.name.value = userLoginModel.name;
      state.email.value = userLoginModel.email;
      state.phNum.value = userLoginModel.phoneNumber;
      state.dob.value = convertDatetimeToString(userLoginModel.dob);
      state.dobInDateTime.value = userLoginModel.dob;
      state.image.value = userLoginModel.image;

      usernameController.text = userLoginModel.userName;
      emailController.text = userLoginModel.email;
      nameController.text = userLoginModel.name;
      dobController.text = convertDatetimeToString(userLoginModel.dob);
      print(
          'DOB :::::::::::::: ${convertDatetimeToString(userLoginModel.dob)}');
    }
  }

  // update Profile
  Future<bool> updateProfile() async {
    final Map<String, dynamic> patchBody = {
      "email_id": emailController.text,
      "user_name": usernameController.text,
      "name": nameController.text,
      "dob": state.dobInDateTime.value,
      "image": state.image.value,
      "updated_at": DateTime.now(),
    };

    return await services.updateUserData(patchBody);
  }

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

  // select Date
  Future selectDate(BuildContext context,
      {required DateTime initialDate}) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      // initialDate: DateTime.now(),
      initialDate: initialDate,
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      // state.dob.value = convertDatetimeToString(selected);
      state.dobInDateTime.value = selected;
    }
  }

  // Convert Datetime to String
  String convertDatetimeToString(DateTime date) {
    var outputDate = DateFormat.yMd().format(date);
    return outputDate;
  }

// Uploading
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      await _uploadFile();
    } else {
      print('No image selected');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      await _uploadFile();
    } else {
      print('No image selected');
    }
  }

  Future _uploadFile() async {
    if (photo == null) return;
    // final filename = getRandomString(15) + photo!.path;
    String filename = 'avatar';
    try {
      final ref = FirebaseStorage.instance.ref('chat').child(filename);

      // Put file in that reference and listen uploading process
      await ref.putFile(photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
          case TaskState.success:
            // String imgUrl = await downloadImageUrl(filename);
            await downloadImageUrl(filename);
            showTextMessageToaster('Done');
        }
      });
    } catch (e) {
      print('There\'s an error $e');
    }
  }

  Future downloadImageUrl(String filename) async {
    final ref = FirebaseStorage.instance.ref('chat').child(filename);
    final downloadLink = await ref.getDownloadURL();
    if (downloadLink.isNotEmpty) {
      state.image.value = downloadLink;
      print(downloadLink);
      await updateProfile().then((value) {
        onReady();
      });
    }
    // return await ref.getDownloadURL();
  }
}
