import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/orderslist.dart';
import 'package:provider/provider.dart';
import 'package:kirana/pages/orderitems.dart';
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

    return Column(children: [_Tile(order), Divider(thickness: 5, color: Colors.blue,)]);
  }

  Widget _Tile(OrdersModel order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Column(
                  children: <Widget>[
                    Text("Date : ${DateTime.fromMillisecondsSinceEpoch(order.id)}",
                          style: TextStyle(color: Colors.green[800],fontSize: 18),
                    ),
                    Container(
                        child: Text(
                          'Price : ' + order.price().toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[800]),
                        )),
                    FlatButton(
                      onPressed: ()
                      {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => OrderItemsPage(order)));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.explore),
                          Text('Expand'),
                        ]
                      ),
                    ),
                  ],
                ),
          );
  }
}
