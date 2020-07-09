import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  final name='Items';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body :Container(child: Text("Items page")),
      appBar: AppBar(title: Text("Items")),
    );
  }
}