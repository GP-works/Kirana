import 'package:flutter/material.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/items.dart';
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
        return StreamBuilder<List<Item>>(
            stream: catalog.items.addFromFireStore(catalog.selectedshopid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView(children: [
                  for (var item in (snapshot.data)) MenuItem(item),
                ]);
              }
            });
      }),
      appBar: AppBar(
        title: Text("APP_NAME"),
        actions: <Widget>[CartIcon()],
      ),
    );
  }
}
