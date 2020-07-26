import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/Item.dart';

class MenuItem extends StatefulWidget {
  final Item item;
  MenuItem(this.item);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int count = 0;
  User user;
  bool showDescription = false;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context, listen: false);
    return Column(children: [_Tile(widget.item, context), Divider()]);
  }

  void getCount(CartModel cart, Item item) async {
    int coun = await cart.getcount(item.id, user.uid);
    if (this.mounted) {
      setState(() {
        count = coun;
      });
    }
  }

  Widget _Tile(Item item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.showDescription = !this.showDescription;
      },
      child: Container(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Container(
        child:Column(
          children: <Widget>[
            Row(
             children: <Widget>[
          CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
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
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        item.originalPrice.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red[800]),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          item.price.toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[800]),
                        )),
                  ],
                ),
                Consumer<CartModel>(builder: (context, cartp, child) {
                  getCount(cartp, item);
                  return (count == 0)
                      ? buttonFlat(cartp, item, context)
                      : buttonIncrementDecrement(cartp, item, context);
                }),
              ],
            ),
          ),
        
        ],
      ),
      if(this.showDescription)
              Text('${item.description}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue
              ),
              )
      ],
    ))));
  }
  

  Widget buttonFlat(CartModel cart, Item item, BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 20,
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: RaisedButton(
              child: Text(
                "Add to Cart".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.amber[700],
              onPressed: () {
                _createitem(cart, item, context);
              },
            )));
  }

  Widget buttonIncrementDecrement(
      CartModel cart, Item item, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.remove),
            hoverColor: Colors.red,
            onPressed: () {
              _decrementCount(cart, item, context);
            },
            color: Colors.red,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text('$count')),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _incrementCount(cart, item, context);
            },
            color: Colors.green,
          ),
        ]),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.white60),
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _createitem(CartModel cart, Item item, BuildContext context) async {
    var shopProvider = Provider.of<Shops>(context, listen: false);
    cart.createentry(item.name, item.price, shopProvider.selectedshopid,
        item.id, item.imageurl, user.uid);
    shopProvider.items.edititem();
  }

  void _incrementCount(CartModel cart, Item item, BuildContext context) async {
    cart.incrementitem(item.id, count, user.uid);
    var shopProvider = Provider.of<Shops>(context, listen: false);
    shopProvider.items.edititem();
  }

  void _decrementCount(CartModel cart, Item item, BuildContext context) async {
    cart.decrementitem(item.id, count, user.uid);
    var shopProvider = Provider.of<Shops>(context, listen: false);
    shopProvider.items.edititem();
  }
}
