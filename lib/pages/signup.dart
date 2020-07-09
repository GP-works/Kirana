import 'package:flutter/material.dart';
import 'package:kirana/widgets/VerticalText.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/RedirectSignIn.dart';


class SignUpPage extends StatelessWidget {
  final name='signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    VerticalText('Sign Up'),
                    DescriptionText('We can start something new')
                  ],
                ),
                TextFieldWidget('Name'),
                TextFieldWidget('Email'),
                TextFieldWidget('Password'),
                OkButton(),
                RedirectSignIn()
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