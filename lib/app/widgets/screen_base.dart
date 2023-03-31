import 'package:flutter/material.dart';

class ScreenBase extends StatelessWidget {
  const ScreenBase({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }
}
