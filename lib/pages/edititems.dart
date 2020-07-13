import 'package:flutter/material.dart';

class EditItemsPage extends StatelessWidget {
  final name = 'edititems';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("EditItems page")),
      appBar: AppBar(title: Text("EditItems")),
    );
  }
}
