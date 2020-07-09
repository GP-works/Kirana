import 'package:flutter/material.dart';
import 'package:kirana/widgets/VerticalText.dart';
import 'package:kirana/widgets/TextLogin.dart';
import 'package:kirana/widgets/EmailInput.dart';
import 'package:kirana/widgets/PasswordInput.dart';
import 'package:kirana/widgets/RedirectSignUp.dart';
import 'package:kirana/widgets/SignInButton.dart';

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
                  children: <Widget>[VerticalText(), TextLogin()],
                ),
                InputEmail(),
                PasswordInput(),
                SigninButton(),
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
