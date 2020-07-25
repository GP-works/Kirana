import 'package:flutter/material.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/order_widget.dart';
import 'package:kirana/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/user.dart';

class OrdersPage extends StatelessWidget {
  final name = 'Orders';

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Container(
      child: StreamBuilder<List<Order>>(
        stream: user.role != 'owner'
            ? getUserOrders(user.uid)
            : getOwnerOrders(user.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                drawer: DrawerPage(),
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          } else {
            List<Order_widget> list = [];
            for (var item in (snapshot.data)) {
              list.add(Order_widget(item));
            }
            return Scaffold(
              drawer: DrawerPage(),
              body: ListView(children: list),
              appBar: AppBar(
                title: Text("APP_NAME"),
                actions: <Widget>[CartIcon()],
              ),
            );
          }
        },
      ),
    );
  }
}
