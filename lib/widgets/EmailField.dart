import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailField extends StatelessWidget {
  final controller;
  EmailField(this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10,
                20, MediaQuery.of(context).size.width / 10, 5),
            child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (!EmailValidator.validate(value)) {
                    return "please enter valid email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                  labelText: "Email",
                ))));
  }
}
