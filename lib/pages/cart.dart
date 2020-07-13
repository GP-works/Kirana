import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/widgets/cartitem_widget.dart';

import 'package:provider/provider.dart';
import 'package:kirana/models/items.dart';

class CartPage extends StatelessWidget {
  final name = 'Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ItemsModel(),
          ),
          ChangeNotifierProxyProvider<ItemsModel,CartModel>(
            create: (BuildContext context) => CartModel(),
            update: (context, items, cart) {
              cart.catalog = items;
              return cart;
            },
          ),

        ],
        child: Consumer<CartModel>(builder: (context, catalog, child) {
          return ListView(children: [
            catalog.items.forEach((k, v) => CartItem(k))
          ]);
        }),
      ),
      appBar: AppBar(title: Text("Cart")),
    );
  }
}
