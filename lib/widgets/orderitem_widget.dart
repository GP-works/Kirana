import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kirana/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderItem_widget extends StatefulWidget {
  final int id;
  OrderItem_widget(this.id);

  @override
  _OrderItem_widgetState createState() => _OrderItem_widgetState();
}

class _OrderItem_widgetState extends State<OrderItem_widget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrdersModel>(context);
    Item item = orderProvider.items.getItemById(widget.id);
    count = orderProvider.items[widget.id];

    return Column(children: [_Tile(item), Divider()]);
  }

  Widget _Tile(Item item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:item.imageurl,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}