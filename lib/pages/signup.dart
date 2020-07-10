import 'package:flutter/material.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/pages/signin.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                DescriptionText('Sign Up'),
                TextFieldWidgetWithValidation('Name'),
                TextFieldWidgetWithValidation('Email'),
                TextFieldWidgetWithValidation('Password'),
                OkButton("Ok"),
                RedirectPage(SignInPage(), 'Sign in', 'Have we met before')
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}
