import 'package:flutter/material.dart';

enum SnackBarType {
    error,
    success
}

class Utils {

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, SnackBarType type) {
    if(text == null) return;

    final snackbarcolor;

    if(type == SnackBarType.error){
      snackbarcolor = const Color.fromARGB(255, 254, 69, 86);
    } else {
      snackbarcolor = const Color.fromARGB(255,88, 101, 242);
    }

    final snackbar = SnackBar(
      content: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: snackbarcolor,
      behavior: SnackBarBehavior.floating,
    );

    messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackbar);
  }
}