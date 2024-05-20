import 'package:flutter/material.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MessageAlert {
  void showMessage(String msg) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
