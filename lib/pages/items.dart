import 'package:flutter/material.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/menuitem_widget.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatelessWidget {
  final name = 'Items';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      body: Consumer<Shops>(builder: (context, catalog, child) {
        return ListView(children: [
          for (var item in (catalog.items.items)) MenuItem(item.id),
        ]);
      }),
      appBar: AppBar(
        title: Text("APP_NAME"),
        actions: <Widget>[CartIcon()],
      ),
    );
  }
}
