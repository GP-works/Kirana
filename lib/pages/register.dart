import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kirana/widgets/RegisterForm.dart';

class Register extends StatelessWidget {
  final name = 'Register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RegisterForm(),
    );
  }
}
