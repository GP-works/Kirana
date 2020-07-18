import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/shops.dart';

class ShopPage extends StatefulWidget {
  final String id;
  ShopPage(this.id);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<ShopPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<Shops>(context);
    Shop shop = shopProvider.getShopById(widget.id);

    return Column(children: [_Tile(shop), Divider()]);
  }

  Widget _Tile(Shop shop) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: shop.imageurl,
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
}
