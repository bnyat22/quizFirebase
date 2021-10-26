import 'package:flutter/material.dart';

class MyAppBar {
  final Function toggle;
  final bool isOn;

  const MyAppBar({Key? key, required this.toggle, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: Text("TITLE"), actions: [
      Switch(
          value: isOn,
          onChanged: (val) {
            toggle();
          }),
    ]);
  }
}
