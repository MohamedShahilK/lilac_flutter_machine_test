// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/business_logic/auth/state.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';

class AuthController extends GetxController {
  final state = AuthState();

  final phonenumController = TextEditingController();
  final pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Send Otp
  Future<bool> performFirebasePhoneAuth() async {
    bool isLoginSuccess = false;
    try {
      await auth
          .verifyPhoneNumber(
            phoneNumber: '+91${phonenumController.text}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              UserCredential result =
                  await auth.signInWithCredential(credential);
              User? user = result.user;
              if (user != null) {
                final uid = user.uid;
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
            },
            codeAutoRetrievalTimeout: (String newVerificationCode) {
              state.verificationId.value = newVerificationCode;
            },
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
      final PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId.value,
        smsCode: state.phoneOtp.value,
      );
      return _firebaseSignInWithCredential(_credential);
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
          final User _user = value.user!;
          // await _verifiedAndPerformRegister(_user);
          // const FlutterSecureStorage().write(
          //   key: SharedPrefKey.kLoginUserId,
          //   value: _user.uid,
          // );
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
}
