// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/business_logic/profile/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/profile/widgets/custom_button.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          // onTap: () => Get.back(),
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Logo
          const SizedBox(height: 10),
          Stack(
            children: const [
              CircleAvatar(
                maxRadius: 60,
                // child: Image.asset('assets/avatar.jpg'),
                // backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  maxRadius: 17,
                  backgroundColor: Colors.yellow,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),

          //
          Container(),

          const SizedBox(height: 30),

          // Textfields
          const SizedBox(height: 20),
          _TextFieldItem(
            textEditingController: controller.usernameController,
            field: 'Username',
            icon: Icons.account_box_outlined,
          ),
          const SizedBox(height: 20),
          _TextFieldItem(
            textEditingController: controller.nameController,
            field: 'Name',
            icon: Icons.person_2_outlined,
          ),
          const SizedBox(height: 20),
          _TextFieldItem(
            textEditingController: controller.emailController,
            field: 'Email',
            icon: Icons.alternate_email_rounded,
          ),
          const SizedBox(height: 20),
          // _TextFieldItem(
          //   textEditingController: controller.dobController,
          //   field: 'DOB',
          //   icon: Icons.date_range_outlined,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('DOB: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 20),
              Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 3, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.grey))),
                  onPressed: () async {
                    await controller.selectDate(context,
                        initialDate: controller.state.dob.value);
                  },
                  child: Text(
                    controller
                        .convertDatetimeToString(controller.state.dob.value),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),

          // Save Button
          CustomButton(
            buttonBgColor: Colors.grey[700],
            field: 'Save',
            onTap: () async {
              // controller.state.isProfilePage.value
              //     ? null
              //     : Get.offAndToNamed('/home');
              Loader.show(context,
                  progressIndicator: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.grey[400]!, size: 30));
              await controller.updateProfile().then((value) {
                Loader.hide();
                showTextMessageToaster('Done');
              }).onError((error, stackTrace) {
                Loader.hide();
              });
            },
          )
        ],
      ),
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  const _TextFieldItem({
    Key? key,
    required this.textEditingController,
    required this.field,
    required this.icon,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String field;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: textEditingController,
        cursorColor: Colors.grey,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            prefixIcon: Icon(icon, color: Colors.black54),
            labelText: field,
            labelStyle: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}
