import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/shops.dart';

class ShopPage extends StatefulWidget {
  Shop shop;
  ShopPage(this.shop);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<Shops>(context);
    return Column(children: [
      Tile(widget.shop, shopProvider, context),
      Divider(),
    ]);
  }
}

Widget Tile(Shop shop, Shops shopProvider, context) {
  return ListTile(
    onTap: () {
      shopProvider.setItems(shop.userid);
      Navigator.pushReplacementNamed(context, '/items');
    },
    isThreeLine: true,
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        shop.name.toUpperCase(),
        style: TextStyle(fontSize: 20),
      ),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.all(2.0),
      child: RichText(
        text: TextSpan(
          text: "" + shop.owner + ",",
          style: TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
              text: "  " + shop.address,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    ),
  );
}
/*Widget _Tile(Shop shop) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(3),
                    width: (3 * MediaQuery.of(context).size.width) / 4 - 50,
                    child: Text(
                      shop.name,
                      style: TextStyle(fontSize: 18),
                      softWrap: true,
                      maxLines: 2,
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(shop.owner),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        shop.address,
                        style: TextStyle(color: Colors.red[800]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}*/
