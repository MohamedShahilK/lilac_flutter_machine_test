// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/business_logic/auth/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/auth/widgets/custom_button.dart';
import 'package:lilac_flutter_machine_test/presentation/auth/widgets/custom_otp_textfield.dart';
import 'package:lilac_flutter_machine_test/services/storage_service.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';

import 'widgets/custom_textfield.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Obx(
        () => !controller.state.isOtpPage.value
            ? _PhoneNumberWidget(controller: controller)
            : _OtpSectionWidget(controller: controller),
      ),
    );
  }
}

class _OtpSectionWidget extends StatelessWidget {
  final AuthController controller;

  const _OtpSectionWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'OTP Verification',
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 20,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'OTP has been sent to +91${controller.phonenumController.text}',
        ),

        // Pinput
        CustomOtpTextfield(controller: controller),

        // Btn
        // CustomButton(
        //   onTap: () {},
        // )
      ],
    );
  }
}

class _PhoneNumberWidget extends StatelessWidget {
  const _PhoneNumberWidget({required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        // logo
        const Icon(Icons.lock, size: 80),

        const SizedBox(height: 30),

        Text(
          // 'Welcome back you\'ve been missed!',
          'We\'ll send an SMS with a verification code...',
          style: TextStyle(color: Colors.grey[700], fontSize: 18),
        ),

        const SizedBox(height: 50),

        // PhoneNumber Field
        Form(
          key: controller.formKey,
          child: CustomTextField(
            authController: controller,
            hintText: 'Phone Number',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputType: TextInputType.phone,
            prefix: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text('+91'),
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Signin Button
        CustomButton(
          onTap: () {
            // print('hello');
            FocusScope.of(context).requestFocus(FocusNode());
            if (controller.formKey.currentState == null) {
              return;
            }
            final isValid = controller.formKey.currentState!.validate();
            if (isValid) {
              controller.state.isOtpPage.value = true;
              controller.performFirebasePhoneAuth().then((value) async {
                if (value) {
                  // final userId = StorageService.to.getString('userId');
                  // final haveAccAlready =
                  //     await controller.isUserAlreadyHaveAccount(userId);

                  // if (!haveAccAlready) {
                  //   Get.offAndToNamed('/editProfile',
                  //       parameters: {'isProfilePage': 'true'});
                  // } else {
                  //   Get.offAndToNamed('/home');
                  // }
                }
                //  else {
                //   showTextMessageToaster('Login failed');
                // }
              });
            }
            // if (controller.formKey.currentState!.validate()) {

            // }
          },
        )
      ],
    );
  }
}
