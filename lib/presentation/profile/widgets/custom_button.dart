// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.field,
    required this.onTap,
    this.buttonBgColor,
  }) : super(key: key);

  final String field;
  final VoidCallback onTap;
  final Color? buttonBgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.only(top: 65),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26))),
            backgroundColor:
                MaterialStateProperty.all(buttonBgColor ?? Colors.grey[400]),
            elevation: MaterialStateProperty.all(0),
            fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width * (3 / 5), 45))),
        child: Text(
          field,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
