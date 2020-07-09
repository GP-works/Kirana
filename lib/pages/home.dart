import 'package:flutter/material.dart';
import 'cart.dart';
import 'signin.dart';
import 'signup.dart';
import 'edititems.dart';
import 'orders.dart';
import 'register.dart';
import 'items.dart';
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
class Button extends StatelessWidget {
  StatelessWidget widget;
  Button({Key key, this.widget}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(child:Text(widget.name),
      onPressed: ,)
  }
}
