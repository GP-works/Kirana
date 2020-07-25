import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/models/items.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartItem extends StatefulWidget {
  final Orderitem orderitem;
  CartItem(this.orderitem);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int count = 0;
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context, listen: false);
    return Column(children: [_Tile(widget.orderitem), Divider()]);
  }

  void getCount(CartModel cart, Orderitem item) async {
    int coun = await cart.getcount(item.menuitemid, user.uid);
    setState(() {
      count = coun;
    });
  }

  Widget _Tile(Orderitem item) {
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
                          (item.price * count).toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[800]),
                        )),
                  ],
                ),
                Consumer<CartModel>(
                  builder: (context, cartp, child) =>
                      buttonIncrementDecrement(cartp, item),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonIncrementDecrement(CartModel cart, Orderitem item) {
    getCount(cart, item);
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: Container(
        child: Row(children: [
          FlatButton(
            onPressed: () {
              _delete(cart, item);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Delete'),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            hoverColor: Colors.red,
            onPressed: () {
              _decrementCount(cart, item);
            },
            color: Colors.red,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text("$count")),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _incrementCount(cart, item);
            },
            color: Colors.green,
          ),
        ]),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.white60),
      ),
    );
  }

  void _incrementCount(CartModel cart, Orderitem item) async {
    cart.incrementitem(item.menuitemid, count, user.uid);
  }

  void _decrementCount(CartModel cart, Orderitem item) async {
    cart.decrementitem(item.menuitemid, count, user.uid);
  }

  void _delete(CartModel cart, Orderitem item) {
    cart.deleteItem(item.menuitemid, user.uid);
  }
}
