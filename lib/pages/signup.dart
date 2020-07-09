import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final name='signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body :Container(child: Text("Signup page")),
      appBar: AppBar(title: Text("Signup")),
    );
  }
}