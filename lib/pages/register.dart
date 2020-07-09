import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final name='Register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body :Container(child: Text("Register page")),
      appBar: AppBar(title: Text("Register")),
    );
  }
}