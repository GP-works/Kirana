import 'package:flutter/material.dart';
import 'package:kirana/models/user.dart';
import 'package:kirana/pages/navigation.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/items.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/models/orders.dart';
import 'package:kirana/models/orderslist.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              User user = User();
              return user;
            },
          ),
          ChangeNotifierProvider(
            create: (context) => ItemsModel(),
          ),
          ChangeNotifierProxyProvider<ItemsModel, CartModel>(
            create: (BuildContext context) => CartModel(),
            update: (context, items, cart) {
              cart.catalog = items;
              return cart;
            },
          ),
          ChangeNotifierProvider(
            create: (context) => OrdersListModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrdersModel(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              "/signin": (context) => SignInPage(),
              "/signup": (context) => SignUpPage()
            },
            home: Navigation()));
  }
}
