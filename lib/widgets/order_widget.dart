import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/orderslist.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/orders.dart';

class Order_widget extends StatefulWidget {
  final int id;
  Order_widget(this.id);

  @override
  _Order_widgetState createState() => _Order_widgetState();
}

class _Order_widgetState extends State<Order_widget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrdersListModel>(context);
    OrdersModel order = orderProvider.getItemById(widget.id);

    return Column(children: [_Tile(order), Divider()]);
  }

  Widget _Tile(OrdersModel order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("${DateTime.fromMillisecondsSinceEpoch(order.hashCode)}"),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    order.price().toString(),
                    style: TextStyle(fontSize: 20, color: Colors.green[800]),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
