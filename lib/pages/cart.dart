import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/widgets/cartitem_widget.dart';

import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final name = 'Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartModel>(builder: (context, cart, child) {
        List<CartItem> list = [];
        cart.items.forEach((k, v) => list.add(CartItem(k)));
        return ListView(children: list);
      }),
      appBar: AppBar(title: Text("Cart")),
    );
  }
}
