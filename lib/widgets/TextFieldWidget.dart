import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextFieldWidget extends StatelessWidget {
  final name;

  TextFieldWidget(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              fillColor: Colors.green,
              labelText: '$name',
              labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
        ),
      ),
    );
  }
}

class TextFieldWidgetWithValidation extends StatelessWidget {
  final String name;
  final controller;
  bool obscure;

  TextFieldWidgetWithValidation(this.name, this.controller) {
    obscure = name == "password";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10,
                20, MediaQuery.of(context).size.width / 10, 5),
            child: TextFormField(
                controller: controller,
                obscureText: obscure,
                validator: (value) {
                  if ((value.isEmpty)) {
                    return "please enter valid Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                  labelText: name,
                ))));
  }
}

class NumberFieldWidgetWithValidation extends StatelessWidget {
  final String name;
  final controller;

  NumberFieldWidgetWithValidation(this.name, this.controller);

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
                if ((value.isEmpty)) {
                  return "please enter valid $name";
                } else {
                  try {
                    var n = double.parse(controller.text);
                    return null;
                  } on FormatException {
                    return "Invalid format";
                  }
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                labelText: name,
              ),
              keyboardType: TextInputType.number,
            )));
  }
}

class pinCodeWidget extends StatelessWidget {
  final String name;
  final controller;

  pinCodeWidget(this.name, this.controller);

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
                if ((value.isEmpty)) {
                  return "please enter valid $name";
                } else {
                  try {
                    var n = int.parse(controller.text);
                    return null;
                  } on FormatException {
                    return "Invalid format";
                  }
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                labelText: name,
              ),
              keyboardType: TextInputType.number,
            )));
  }
}

class MultilineTextWidgetWithValidation extends StatelessWidget {
  final String name;
  final controller;

  MultilineTextWidgetWithValidation(this.name, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, 20,
            MediaQuery.of(context).size.width / 10, 5),
        child: Container(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if ((value.isEmpty)) {
                return "please enter valid $name";
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                labelText: name,
                hintText: "press enter for a new line"),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
