// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';

import 'package:lilac_flutter_machine_test/business_logic/auth/controller.dart';

import '../../../services/storage_service.dart';

class CustomOtpTextfield extends StatelessWidget {
  CustomOtpTextfield({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Pinput(
          controller: controller.pinController,
          // focusNode: ,
          length: 6,
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: defaultPinTheme,
          hapticFeedbackType: HapticFeedbackType.mediumImpact,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 22,
                height: 2,
                color: Colors.black87,
              ),
            ],
          ),
          focusedPinTheme: defaultFocusPinTheme,
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: Colors.redAccent),
          ),
          onCompleted: (value) {
            controller.state.phoneOtp.value = value;
            Loader.show(
              context,
              progressIndicator: LoadingAnimationWidget.discreteCircle(
                  color: Colors.grey, size: 24),
            );
            controller.performManualPhoneVerification().then((status) async {
              if (status) {
                // // Get.offAndToNamed('/home');
                // final userId = StorageService.to.getString('userId');
                // final haveAccAlready =
                //     await controller.isUserAlreadyHaveAccount(userId);

                // if (!haveAccAlready) {
                //   Get.offAndToNamed('/editProfile',
                //       parameters: {'isProfilePage': 'false'});
                // } else {
                //   Get.offAndToNamed('/home');
                // }
                Loader.hide();
                Get.offAndToNamed('/home');
              } else {
                showTextMessageToaster('Login failed');
                Loader.hide();
              }
            });
          },
          onChanged: (value) => controller.state.phoneOtp.value = value,
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 48,
    height: 48,
    // textStyle: TextStyles.normalMediumStyle,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black87),
    ),
  );

  final defaultFocusPinTheme = PinTheme(
    width: 48,
    height: 48,
    // textStyle: TextStyles.normalMediumStyle,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey[200],
      border: Border.all(color: Colors.black87),
    ),
  );
}
