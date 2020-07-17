import 'package:flutter/material.dart';
import 'package:kirana/widgets/sinout_button.dart';
import 'edititems.dart';
import 'orders.dart';
import 'register.dart';
import 'items.dart';
import 'package:kirana/widgets/button_widget.dart';
import 'cart.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/user.dart';
import 'signin.dart';
import 'signup.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      return user.isLogged()
          ? Scaffold(
              appBar: AppBar(
                title: Text('Home page'),
                centerTitle: true,
              ),
              body: ListView(
                children: <Widget>[
                  button(CartPage()),
                  button(EditItemsPage()),
                  button(OrdersPage()),
                  button(Register()),
                  button(ItemsPage()),
                  SignOut("${user.name}"),
                ],
              ))
          : SignInPage();
    });
  }
}
