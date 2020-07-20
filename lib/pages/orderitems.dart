import 'package:flutter/material.dart';
import 'package:kirana/models/orders.dart';
import 'package:kirana/widgets/orderitem_widget.dart';

class OrderItemsPage extends StatelessWidget {
  final name = 'OrderItems';
  OrdersModel order;
  OrderItemsPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
          for (var item in this.order.items) OrderItem_widget(item),
        ]),
      appBar: AppBar(title: Text("APP_NAME")),
    );
  }
}
