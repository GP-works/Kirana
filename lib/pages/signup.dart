import 'package:flutter/material.dart';
import 'package:kirana/widgets/VerticalTextSignUp.dart';
import 'package:kirana/widgets/TextNewUser.dart';
import 'package:kirana/widgets/NewName.dart';
import 'package:kirana/widgets/NewEmail.dart';
import 'package:kirana/widgets/PasswordInput.dart';
import 'package:kirana/widgets/SignUpButton.dart';
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
                    VerticalTextSignUp(),
                    TextNewUser()
                  ],
                ),
                NewName(),
                NewEmail(),
                PasswordInput(),
                SignUpButton(),
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