import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showTextMessageToaster(
  String msg, {
  Toast? toastLength,
  int timeInSecForIosWeb = 1,
  double? fontSize,
  ToastGravity? gravity,
  Color? backgroundColor,
  Color? textColor,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: gravity ?? ToastGravity.BOTTOM,
    fontSize: fontSize,
    backgroundColor: backgroundColor,
    textColor: textColor,
    timeInSecForIosWeb: timeInSecForIosWeb,
  );
}
