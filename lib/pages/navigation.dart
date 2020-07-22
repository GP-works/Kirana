import 'package:flutter/material.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/pages/shops.dart';
import 'items.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/user.dart';
import 'signin.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool shop = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Shops>(builder: (context, shops, child) {
      setshop(shops);
      return Consumer<User>(builder: (context, user, child) {
        return user.isLogged()
            ? !shop ? ShopsPage() : ItemsPage()
            : SignInPage();
      });
    });
  }

  void setshop(Shops shops) async {
    bool sho = await shops.getfromSF();
    setState(() {
      shop = sho;
    });
  }
}
