import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  var name;
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
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: '$name',
            labelStyle: TextStyle(
              color: Colors.white70,
              fontSize: 20
            )
          ),
        ),
      ),
    );
  }
}