import 'package:flutter/material.dart';
import 'package:kirana/widgets/GotoCartIcon.dart';
import 'package:kirana/models/orders.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/orderitem_widget.dart';

class OrderItemsPage extends StatelessWidget {
  final name = 'OrderItems';
  Order order;
  OrderItemsPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Orderitem>>(
        stream: getorderitems(order),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Scaffold(
              drawer: DrawerPage(),
              body: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }
          else{
            List<OrderItem_widget> list = [];
            for (var item in (snapshot.data)) {
               list.add(OrderItem_widget(item));
            }
            return Scaffold(
              drawer: DrawerPage(),
              body: ListView(children: list),
              appBar: AppBar(title: Text("APP_NAME"),actions: <Widget>[CartIcon()],),
            );
          }
        },
      ),
    );
  }
}
