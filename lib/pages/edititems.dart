import 'package:flutter/material.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:kirana/pages/addItem.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/editItem_widget.dart';
import 'package:provider/provider.dart';

class EditItemsPage extends StatefulWidget {
  @override
  _EditItemsPageState createState() => _EditItemsPageState();
}

class _EditItemsPageState extends State<EditItemsPage> {
  final name = "edit items";
  Shop shop;
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
        try {
          getshop(Provider.of<User>(context).uid, shops);
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
              if (snapshot.hasData) {
                return ListView(children: [
                  for (var item in snapshot.data) EditItemTile(item),
                ]);
              } else {
                return Center(
                  child: LinearProgressIndicator(),
                );
              }
            });
      }),
    );
  }

  void getshop(String userid, Shops shops) async {
    shop = await shops.getShopByuserId(userid);
  }
}
