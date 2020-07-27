import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/models/location.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:kirana/pages/navigation.dart';
import 'package:kirana/pages/shops.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:provider/provider.dart';
import 'package:kirana/pages/edititems.dart';
import 'package:kirana/pages/orders.dart';
import 'package:kirana/pages/register.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/pages/cart.dart';
import 'package:kirana/pages/signin.dart';
import 'package:kirana/models/orders.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            User user = User();
            return user;
          }),
          ChangeNotifierProvider(create: (context) {
            Shops shop = Shops();
            return shop;
          }),
          ChangeNotifierProvider(create: (context) {
            CartModel cart = CartModel();
            cart.getmenuitemids();
            return cart;
          }),
          ChangeNotifierProvider(create: (context) {
            LocationModel location = LocationModel();
            location.readFromSf();
            return location;
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => Navigation(),
            "/signin": (context) => SignInPage(),
            "/signup": (context) => SignUpPage(),
            "/items": (context) => ItemsPage(),
            "/shops": (context) => ShopsPage(),
            "/register": (context) => Register(),
            "/orders": (context) => OrdersPage(),
            "/cart": (context) => CartPage(),
            "/navigation": (context) => Navigation(),
            "/edit": (context) => EditItemsPage(),
          },
        ));
  }
}
