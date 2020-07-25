import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/orders.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';
import 'package:kirana/pages/orderitems.dart';
import 'package:kirana/models/orders.dart';
import 'package:intl/intl.dart';

class Order_widget extends StatefulWidget {
  final Order order;
  Order_widget(this.order);

  @override
  _Order_widgetState createState() => _Order_widgetState();
}

class _Order_widgetState extends State<Order_widget> {
  int count = 0;
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of(context, listen: false);
    return Column(children: [
      _Tile(widget.order, user),
      Divider(
        thickness: 5,
        color: Colors.blue,
      )
    ]);
  }

  Widget _Tile(Order order, User user) {
    var newFormat = DateFormat("dd MMM yyyy , H:mm");
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Column(
        children: <Widget>[
          user.role == 'user' ? Text("") : Text(order.userName),
          Text(
            "Date : ${newFormat.format(DateTime.fromMillisecondsSinceEpoch(order.createdAt))}",
            style: TextStyle(color: Colors.green[800], fontSize: 18),
          ),
          Container(
              child: Text(
            'Price : ' + order.price.toString(),
            style: TextStyle(fontSize: 20, color: Colors.green[800]),
          )),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderItemsPage(order)));
            },
            child: Column(children: <Widget>[
              Icon(Icons.explore),
              Text('Expand'),
            ]),
          ),
        ],
      ),
    );
  }
}
