import 'package:flutter/material.dart';

import 'package:kirana/widgets/menuitem_widget.dart';

import 'package:provider/provider.dart';
import 'package:kirana/models/items.dart';

class ItemsPage extends StatelessWidget {
  final name = 'Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ItemsModel>(builder: (context, catalog, child) {
        return ListView(children: [
          for (var item in catalog.items) MenuItem(item.id),
        ]);
      }),
      appBar: AppBar(title: Text("Items")),
    );
  }
}
