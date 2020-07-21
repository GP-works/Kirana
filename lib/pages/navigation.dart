import 'package:flutter/material.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/pages/shops.dart';
import 'items.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/user.dart';
import 'signin.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Shops>(builder: (context, shops, child) {
      return Consumer<User>(builder: (context, user, child) {
        return user.isLogged()
            ? shops.items.isEmpty() ? ShopsPage() : ItemsPage()
            : SignInPage();
      });
    });
  }
}
