import 'package:flutter/material.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/pages/signin.dart';


class SignUpPage extends StatelessWidget {
  final name='signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                DescriptionText('Sign Up'),
                TextFieldWidget('Name'),
                TextFieldWidget('Email'),
                TextFieldWidget('Password'),
                OkButton(),
                RedirectPage(SignInPage(), 'Sign in', 'Have we met before')
              ],
            )
          ],
        ),
        ),
    );
  }
}