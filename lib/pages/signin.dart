import 'package:flutter/material.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/signup.dart';

class SignInPage extends StatelessWidget {
  final name = 'signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              DescriptionText('Sign In'),
              TextFieldWidget('Email'),
              TextFieldWidget('Password'),
              OkButton('Ok'),
              RedirectPage(SignUpPage(), 'Sign Up', 'give it a shot')
            ],
          )
        ],
      ),
    ));
  }
}
