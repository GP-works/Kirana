import 'package:flutter/material.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:kirana/pages/addItem.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/editItem_widget.dart';
import 'package:provider/provider.dart';

class EditItemsPage extends StatelessWidget {
  final name = "edit items";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text(
          "Edit items",
        ),
        actions: <Widget>[
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => addItemPage()));
                  },
                  child: Text(
                    "Add a new Item",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  color: Theme.of(context).accentColor,
                )),
          )
        ],
      ),
      body: Consumer<Shops>(builder: (context, shops, child) {
        Shop shop;
        try {
          shop = shops.getShopByuserId(Provider.of<User>(context).uid);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("you don't had a shop registered"),
          ));
          Navigator.pushNamed(context, "/items");
        }
        return StreamBuilder<List<Item>>(
            stream:
                shops.items.addFromFireStore(Provider.of<User>(context).uid),
            builder: (context, snapshot) {
              return ListView(children: [
                for (var item in snapshot.data) EditItemTile(item),
              ]);
            });
      }),
    );
  }
}
