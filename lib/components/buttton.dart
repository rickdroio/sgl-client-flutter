import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String caption;
  final void Function() onPressed;

  const MyButton({super.key, required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(caption));
  }
}
