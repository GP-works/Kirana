import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/widgets/cartitem_widget.dart';
import 'package:kirana/pages/orders.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/database/cart.dart';

class CartPage extends StatelessWidget {
  final name = 'CartItems';

  @override
  Widget build(BuildContext context) {
    return Container(child:
        Consumer2<CartModel, Shops>(builder: (context, cart, shops, child) {
      //List<CartItem> list = [];
      //List<MenuItem> itemslist = [];
      //cart.items.forEach((orderitem) => list.add(CartItem(orderitem.menuitemid)));
      //shops.selectedshop.items.forEach((item) => itemslist.add(MenuItem(item.hashCod)));
      return Consumer<CartModel>(builder: (context, cart, child) {
        return StreamBuilder<List<Orderitem>>(
          stream: cart.fromf(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                  drawer: DrawerPage(),
                  appBar: AppBar(title: Text("APP_NAME"), actions: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            cart.deleteAll();
                          },
                          child: Icon(
                            Icons.delete,
                            size: 26.0,
                            color: Colors.red,
                          ),
                        ))
                  ]),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else {
              return Scaffold(
                drawer: DrawerPage(),
                appBar: AppBar(title: Text("APP_NAME"), actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          cart.deleteAll();
                        },
                        child: Icon(
                          Icons.delete,
                          size: 26.0,
                          color: Colors.red,
                        ),
                      ))
                ]),
                body: ListView(
                  children: <Widget>[
                    for (var item in (snapshot.data)) CartItem(item),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Total price : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${cart.getprice(snapshot.data)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                            fontSize: 18),
                      ),
                      FlatButton(
                        onPressed: () {
                          //orderslist.create_order(cart);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrdersPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "checkout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      }); //CartContents(list, itemslist)),
    }));
  }

/*Widget CartContents(List<CartItem> list, List<MenuItem> itemslist) {
    if (list.length == 0) {
      return Container(
        child: ListView(children: itemslist),
      );
    } else {
      return Container(child: ListView(children: list));
    }
  }*/
}
