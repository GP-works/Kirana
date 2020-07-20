import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
    IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
      Navigator.pushNamed(context, "/cart");
    },);
  }
}