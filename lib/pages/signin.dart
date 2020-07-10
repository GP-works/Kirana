import 'package:flutter/material.dart';
import 'package:kirana/widgets/DescriptionText.dart';
import 'package:kirana/widgets/RedirectPage.dart';
import 'package:kirana/widgets/OkButton.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/signup.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              DescriptionText('Sign In'),
              TextFieldWidgetWithValidation('Email'),
              TextFieldWidgetWithValidation('Password'),
              OkButton('Ok'),
              RedirectPage(SignUpPage(), 'Sign Up', 'give it a shot')
            ],
          )
        ],
      ),
    )
    )
    );
  }
}
