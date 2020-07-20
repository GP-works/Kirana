import 'package:flutter/material.dart';
import 'items.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/user.dart';
import 'signin.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      return user.isLogged()
          ? ItemsPage()
          : SignInPage();
    });
  }
}
