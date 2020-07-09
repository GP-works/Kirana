import 'package:flutter/material.dart';
import 'package:kirana/widgets/VerticalText.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/RedirectSignUp.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';

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
                Row(
                  children: <Widget>[
                    VerticalText('Sign In'),
                    DescriptionText('A World of possibility in an app')
                  ],
                ),
                TextFieldWidget('Email'),
                TextFieldWidget('Password'),
                OkButton(),
                RedirectSignUp()
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
      ),
    );
  }
}
