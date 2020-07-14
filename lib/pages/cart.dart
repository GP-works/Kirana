import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/widgets/cartitem_widget.dart';

import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final name = 'CartItems';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CartModel>(builder: (context, cart, child) {
        List<CartItem> list = [];
        cart.items.forEach((k, v) => list.add(CartItem(k)));
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                  onTap: () { cart.delete_all();},
                  child: Icon(
                  Icons.delete,
                  size: 26.0,
                  color: Colors.red,
                  ),
               )
               )
               ]),
          body: ListView(children: list)
               );
      }),
      );
    /*return Scaffold(
      body: Consumer<CartModel>(builder: (context, cart, child) {
        List<CartItem> list = [];
        cart.items.forEach((k, v) => list.add(CartItem(k)));
        return ListView(children: list);
      }),
      appBar: AppBar(
        title: Text("Cart"),
        actions: <Widget>[
        Padding(
         padding: EdgeInsets.only(right: 20.0),
         child: GestureDetector(
            onTap: () {},
            child: Icon(
            Icons.delete,
            size: 26.0,
            color: Colors.red,
        ),
          )
        )],
        ),
    );*/
  }
}
