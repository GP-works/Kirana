import 'package:flutter/material.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:kirana/pages/editItem.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/items.dart';
import 'package:kirana/models/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

class EditItemTile extends StatefulWidget {
  Item item;
  EditItemTile(this.item);
  @override
  _EditItemTileState createState() => _EditItemTileState();
}

class _EditItemTileState extends State<EditItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_Tile(widget.item), Divider()]);
  }

  Widget _Tile(Item item) {
    var catalog = Provider.of<Shops>(context, listen: false);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: item.imageurl,
            width: MediaQuery.of(context).size.width / 4,
            height: 120,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(3),
                    width: (3 * MediaQuery.of(context).size.width) / 4 - 50,
                    child: Text(
                      item.name,
                      style: TextStyle(fontSize: 18),
                      softWrap: true,
                      maxLines: 2,
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("Price"),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          (item.price).toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[800]),
                        )),
                  ],
                ),
                buttonEdit(catalog, item),
              ],
            ),
          )
        ],
      ),
    );
  }

  buttonEdit(catalog, item) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 20,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "Edit".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Colors.amber[700],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => editItemPage(item)));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        _showMyDialog(catalog, item);
                      },
                    ),
                  ),
                ),
              ],
            )));
  }

  Future<void> _showMyDialog(Shops catalog, Item item) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really Want to remove'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${item.name}",
                  style: TextStyle(
                      color: Colors.red[800], fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 3, 0, 0, 0),
              child: FlatButton(
                child: Text('Yes', style: TextStyle(fontSize: 25)),
                onPressed: () {
                  catalog.items.remove(
                      item, Provider.of<User>(context, listen: false).uid);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
