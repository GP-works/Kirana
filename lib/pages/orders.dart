import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final name='orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body :Container(child: Text("Orders page")),
      appBar: AppBar(title: Text("Orders")),
    );
  }
}