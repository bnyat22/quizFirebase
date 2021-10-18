import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({
    Key? key,
    required this.controller,
    required this.hintQuestion,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintQuestion;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintQuestion));
  }
}

