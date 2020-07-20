import 'package:flutter/material.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/shop_widget.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/shops.dart';

class ShopsPage extends StatelessWidget {
  final name = 'Shops';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      body: Consumer<Shops>(builder: (context, shops, child) {
        return ListView(children: [
          for (var shop in shops.shops) ShopPage(shop.id),
        ]);
      }),
      appBar: AppBar(title: Text("Shops"),actions: <Widget>[CartIcon()],),
    );
  }
}
