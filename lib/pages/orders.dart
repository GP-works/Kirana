import 'package:flutter/material.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/order_widget.dart';
import 'package:kirana/models/orderslist.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  final name = 'Orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      body: Consumer<OrdersListModel>(builder: (context, orderslist, child) {
        return ListView(children: [
          for (var order in orderslist.orders) Order_widget(order.id),
        ]);
      }),
      appBar: AppBar(title: Text("APP_NAME"),actions: <Widget>[CartIcon()],),
    );
  }
}
