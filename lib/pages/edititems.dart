import 'package:flutter/material.dart';
import 'package:kirana/pages/addItem.dart';
import 'package:kirana/widgets/editItem_widget.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/items.dart';
class EditItemsPage extends StatelessWidget {
  final name = "edit items";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit items",),
            actions: <Widget>[
              Center(
                child: Padding(
                    padding: EdgeInsets.only( right: 20.0),
                    child: FlatButton(
                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>addItemPage()));},
                      child: Text(
                        "Add a new Item",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                    )
                ),
              )
            ]
        ,
      ),
    body: Consumer<ItemsModel>(builder: (context, catalog, child) {
      return ListView(children: [
        for (var item in catalog.items) EditItemTile(item.id),
      ]);
    }),
    );
  }
}
