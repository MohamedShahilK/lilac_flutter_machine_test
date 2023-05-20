// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/business_logic/profile/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/profile/widgets/custom_button.dart';
import 'package:lilac_flutter_machine_test/services/extensions.dart';
import 'package:lilac_flutter_machine_test/theme/app_state_notifier.dart';
import 'package:lilac_flutter_machine_test/utils/custom_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyThemeStateNotifier>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          // onTap: () => Get.back(),
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            // color: Colors.black,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          Switch(
            trackColor: provider.isDarkModeOn
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.grey),
            thumbColor: provider.isDarkModeOn
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.transparent),
            thumbIcon: MaterialStateProperty.all(
              Icon(
                provider.isDarkModeOn
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight,
                color: Colors.black,
              ),
            ),
            value: Provider.of<MyThemeStateNotifier>(context).isDarkModeOn,
            onChanged: (boolVal) {
              Provider.of<MyThemeStateNotifier>(context, listen: false)
                  .updateTheme(boolVal);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Logo
          const SizedBox(height: 10),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  showPicker(context);
                },
                child: Obx(() => CircleAvatar(
                      maxRadius: 60,
                      // child: Image.asset('assets/avatar.jpg'),
                      backgroundColor: Colors.grey[100],
                      
                      backgroundImage:controller.state.image.value == ''?null :
                          NetworkImage(controller.state.image.value),
                    )),

                // child: const CircleAvatar(
                //   maxRadius: 60,
                //   // child: Image.asset('assets/avatar.jpg'),
                //   // backgroundColor: Colors.red,
                //   backgroundImage: AssetImage('assets/avatar.jpg') ,
                // ),
              ),
              const Positioned(
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
              Text(
                'DOB: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: provider.isDarkModeOn ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 20),
              Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 3, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        provider.isDarkModeOn ? Colors.grey[800] : Colors.white,
                      ),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.grey))),
                  onPressed: () async {
                    await controller.selectDate(context,
                        initialDate: controller.state.dobInDateTime.value);
                  },
                  child: Text(
                    controller.convertDatetimeToString(
                      controller.state.dobInDateTime.value,
                    ),
                    style: TextStyle(
                      color:
                          provider.isDarkModeOn ? Colors.white : Colors.black,
                    ),
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
                controller.onReady();
                Loader.hide();
                showTextMessageToaster('Done');
                notify(
                    title: 'Lilac Flutter Machine Test',
                    content: 'Profile Details Saved Successfully');
              }).onError((error, stackTrace) {
                Loader.hide();
              });
            },
          )
        ],
      ),
    );
  }

  void showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    await controller.imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  await controller.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
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
    final provider = Provider.of<MyThemeStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: textEditingController,
        cursorColor: Colors.grey,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(
                color: provider.isDarkModeOn ? Colors.white : Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(
                color: provider.isDarkModeOn ? Colors.white : Colors.black54),
          ),
          prefixIcon: Icon(icon,
              color: provider.isDarkModeOn ? Colors.white : Colors.black54),
          labelText: field,
          labelStyle: TextStyle(
              color: provider.isDarkModeOn ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
}
