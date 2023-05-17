// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lilac_flutter_machine_test/business_logic/profile/controller.dart';
import 'package:lilac_flutter_machine_test/presentation/profile/widgets/custom_button.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
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
                    Icons.edit_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),

          //
          Container(),

          //
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Kazhigar',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 3, bottom: 10),
            child: Text(
              'superadmin@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
          ),

          Column(
            children: [
              _profileItem(name: "Kazhigar", icon: Icons.account_box_outlined),
              _profileItem(
                  name: "Mohamed Shahil K", icon: Icons.person_2_outlined),
              _profileItem(
                  name: "superadmin@gmail.com",
                  icon: Icons.alternate_email_rounded),
              _profileItem(name: "05/04/1998", icon: Icons.date_range_outlined),
            ],
          ),

          // Spacer(),
          // Edit Profile Button
          CustomButton(
            field: 'Edit Profile',
            onTap: () {
              Get.toNamed('/editProfile');
            },
          ),

          // LogOut Button
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextButton(
              onPressed: () async {
                await controller.performLogOut();
              },
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26))),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.grey[400]!)),
                  elevation: MaterialStateProperty.all(0),
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * (3 / 8), 45))),
              child: const Text(
                'LogOut',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _profileItem({
    required String name,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 70, bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(width: 25),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
