import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final name = 'cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("Cart page")),
      appBar: AppBar(title: Text("Cart")),
    );
  }
}
