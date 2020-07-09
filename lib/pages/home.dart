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
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Home page'),
              centerTitle: true,
            ),
            body: ListView(
              children: <Widget>[
                button(SignInPage()),
                button(SignUpPage()),
                button(CartPage()),
                button(EditItemsPage()),
                button(OrdersPage()),
                button(Register()),
                button(ItemsPage())
              ],
            )));
  }
}

class button extends StatelessWidget {
  var widget;
  button(this.widget, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Center( child:RaisedButton(
      color: Colors.red,
      child: Text("$widget"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
    )));
  }
}
