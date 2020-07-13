import 'package:flutter/material.dart';
import 'cart.dart';
import 'signin.dart';
import 'signup.dart';
import 'edititems.dart';
import 'orders.dart';
import 'register.dart';
import 'items.dart';
import 'package:kirana/widgets/button_widget.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
