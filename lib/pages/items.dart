import 'package:flutter/material.dart';
import 'package:kirana/widgets/menuitem_widget.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class ItemsPage extends StatelessWidget {
  final name = 'Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        MenuItem('SurfExcel 1kg pack super saver pack ', 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
        MenuItem(lipsum.createSentence(), 80,
            'dajgdlashkj', 100, 'images/example.jpeg'),
      ]),
      appBar: AppBar(title: Text("Items")),
    );
  }
}
