import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class MenuItem extends StatefulWidget {
  final String name;
  final String description;
  final int price;
  final int originalPrice;
  final String image;
  final bool edit;
  MenuItem(
      this.name, this.price, this.description, this.originalPrice, this.image,
      {this.edit = false});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int count = 0;
  Widget cart;

  @override
  Widget build(BuildContext context) {
    cart = count == 0 ? buttonFlat() : buttonIncrementDecrement();
    return Column(children: [_Tile(), Divider()]);
  }

  Widget _Tile() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          Image.asset(
            widget.image,
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
                      widget.name,
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
                        widget.originalPrice.toString(),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red[800]),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          widget.price.toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[800]),
                        )),
                  ],
                ),
                cart
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonFlat() {
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
              onPressed: _incrementCount,
            )));
  }

  Widget buttonIncrementDecrement() {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: Container(
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.remove),
            hoverColor: Colors.red,
            onPressed: _decrementCount,
            color: Colors.red,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text("$count")),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementCount,
            color: Colors.green,
          ),
        ]),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white), color: Colors.white60),
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _incrementCount() {
    setState(() {
      count++;
    });
  }

  void _decrementCount() {
    setState(() {
      count--;
    });
  }
}
