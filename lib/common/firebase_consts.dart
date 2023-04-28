import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_clone/common/app_colors.dart';

class FirebaseConsts {
  static const String posts = 'posts';
  static const String users = 'users';
  static const String reply = 'reply';
  static const String comment = 'comment';
}

void toast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.blueColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
