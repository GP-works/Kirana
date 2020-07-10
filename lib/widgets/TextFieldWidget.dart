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
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
            fillColor: Colors.green,
            labelText: '$name',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20
            )
          ),
        ),
      ),
    );
  }
}
