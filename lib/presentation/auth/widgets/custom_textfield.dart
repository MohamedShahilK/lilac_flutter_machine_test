// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lilac_flutter_machine_test/business_logic/auth/controller.dart';
import 'package:lilac_flutter_machine_test/theme/app_state_notifier.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.authController,
    required this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
    this.prefix,
  }) : super(key: key);

  final AuthController authController;

  final String hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        // key: authController.formKey,
        controller: authController.phonenumController,
        obscureText: obscureText,
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone Number is Empty';
          } else if (value.length < 10) {
            return 'Enter 10 digit valid number';
          } else if (value.length > 10) {
            return 'Enter 10 digit valid number, Field has ${value.length} digits';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          prefix: prefix,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
