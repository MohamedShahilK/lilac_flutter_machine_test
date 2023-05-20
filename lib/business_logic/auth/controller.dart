// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/auth/state.dart';
import 'package:lilac_flutter_machine_test/services/storage_service.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';

class AuthController extends GetxController {
  final state = AuthState();

  final phonenumController = TextEditingController();
  final pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  final userCollec = FirebaseFirestore.instance.collection('User data table');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onInit();
    // pinController.text = state.phoneOtp.value;
  }

  // Send Otp
  Future<bool> performFirebasePhoneAuth() async {
    bool isLoginSuccess = false;
    try {
      await auth
          .verifyPhoneNumber(
            phoneNumber: '+91${phonenumController.text}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              //
              // pinController.text = credential.smsCode!;
              print("Pin COde : ${credential.smsCode!}");
              state.phoneOtp.value = credential.smsCode!;
              //
              UserCredential result =
                  await auth.signInWithCredential(credential);
              User? user = result.user;
              if (user != null) {
                // final uid = user.uid;
                isLoginSuccess =
                    await _firebaseSignInWithCredential(credential);
              } else {
                print('Error');
              }
            },
            verificationFailed: (FirebaseAuthException error) {
              showTextMessageToaster('Verification failed');
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showTextMessageToaster('Code sent successfully');
              state.verificationId.value = verificationId;
              state.forceResendingToken.value = forceResendingToken!;
            },
            codeAutoRetrievalTimeout: (String newVerificationCode) {
              state.verificationId.value = newVerificationCode;
            },
            // forceResendingToken: ,
            timeout: const Duration(seconds: 60),
          )
          .then((value) {})
          .onError((error, stackTrace) {
        isLoginSuccess = false;
      });

      return isLoginSuccess;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //
  Future<bool> performManualPhoneVerification() async {
    // if (phoneOtpStream.value.isNotEmpty &&
    //     phoneVerificationCode.value.isNotEmpty) {

    if (state.phoneOtp.value.isNotEmpty) {
      // Create a PhoneAuthCredential with the code
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId.value,
        smsCode: state.phoneOtp.value,
      );
      return await _firebaseSignInWithCredential(credential);
    } else {
      return false;
    }
  }

  Future<bool> _firebaseSignInWithCredential(
    AuthCredential authCredential,
  ) async {
    bool status = false;
    try {
      await FirebaseAuth.instance
          .signInWithCredential(authCredential)
          .then((value) async {
        if (value.user != null) {
          final User user = value.user!;
          await handleUserDataCreation(user);
          // const FlutterSecureStorage().write(
          //   key: SharedPrefKey.kLoginUserId,
          //   value: _user.uid,
          // );

          StorageService.to.setString('userId', user.uid);

          status = true;
          //here, get all cart items from network and pass to hive db
          // await cartRepository.transferNetworkCartItemToHive(_user.uid);
        } else {
          status = false;
        }
      });
    } catch (e) {
      status = false;
      // CustomException(
      //   e.toString(),
      //   message:
      //       'Firebase sign in with credentials failed, credentials - $authCredential',
      // );
    }
    return status;
  }

  Future handleUserDataCreation(User userData) async {
    bool isUserHaveAccount = await isUserAlreadyHaveAccount(userData.uid);
    if (!isUserHaveAccount) {
      try {
        userCollec.doc(userData.uid).set({
          'user_id': userData.uid,
          'user_name': 'user',
          'phone_number': userData.phoneNumber ?? '',
          'email_id': 'Add Email',
          'name': 'Add Name',
          'dob': DateTime.now(),
          'image': '',
          'created_at': DateTime.now(),
          'updated_at': DateTime.now(),
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> isUserAlreadyHaveAccount(String userId) async {
    bool searchResult = false;

    final DocumentSnapshot checkUserPresence =
        await userCollec.doc(userId).get();

    if (checkUserPresence.exists) {
      searchResult = true;
    }
    return searchResult;
  }

  // Resend Otp
  Future resendOtp() async {
    bool isLoginSuccess = false;
    try {
      await auth
          .verifyPhoneNumber(
            phoneNumber: '+91${phonenumController.text}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              //
              // pinController.text = credential.smsCode!;
              print("Pin COde : ${credential.smsCode!}");
              state.phoneOtp.value = credential.smsCode!;
              //
              UserCredential result =
                  await auth.signInWithCredential(credential);
              User? user = result.user;
              if (user != null) {
                // final uid = user.uid;
                isLoginSuccess =
                    await _firebaseSignInWithCredential(credential);
              } else {
                print('Error');
              }
            },
            verificationFailed: (FirebaseAuthException error) {
              showTextMessageToaster('Verification failed');
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showTextMessageToaster('Code sent successfully');
              state.verificationId.value = verificationId;
              state.forceResendingToken.value = forceResendingToken!;
            },
            codeAutoRetrievalTimeout: (String newVerificationCode) {
              state.verificationId.value = newVerificationCode;
            },
            timeout: const Duration(seconds: 60),
            forceResendingToken: state.forceResendingToken.value,
          )
          .then((value) {})
          .onError((error, stackTrace) {
        isLoginSuccess = false;
      });

      return isLoginSuccess;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
