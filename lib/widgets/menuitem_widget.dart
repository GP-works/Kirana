import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/Item.dart';

class MenuItem extends StatefulWidget {
  final int id;
  final bool edit;
  MenuItem(this.id, {this.edit = false});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int count = 0;


  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartModel>(context);
    Item item = cartProvider.catalog.getItemById(widget.id);
    if(cartProvider.items.containsKey(widget.id))
    {count =0;}
    else{
      count= cartProvider.items[widget.id];
    }

    return Column(children: [_Tile(item), Divider()]);
  }

  Widget _Tile(Item item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          Image.asset(
            item.imageurl,
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
                Consumer<CartModel>(
                  builder: (context,cartp,child)=> !cartp.items.containsKey(widget.id)
                      ? buttonFlat(cartp)
                      : buttonIncrementDecrement(cartp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonFlat(CartModel cart) {
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
              onPressed:(){ _incrementCount(cart);},
            )));
  }

  Widget buttonIncrementDecrement(CartModel cart) {
    if(!cart.items.containsKey(widget.id))
    {count =0;}
    else{
      count= cart.items[widget.id];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: Container(
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.remove),
            hoverColor: Colors.red,
            onPressed:(){ _decrementCount(cart);},
            color: Colors.red,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text("$count")),
          IconButton(
            icon: Icon(Icons.add),
            onPressed:(){ _incrementCount(cart);},
            color: Colors.green,
          ),
        ]),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.white60),
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _incrementCount(CartModel cart) {
      cart.add(widget.id);
  }

  void _decrementCount(CartModel cart) {
      cart.remove(widget.id);
  }
}
