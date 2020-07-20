import 'package:flutter/material.dart';
import 'package:kirana/models/cart.dart';
import 'package:kirana/models/orderslist.dart';
import 'package:kirana/widgets/cartitem_widget.dart';
import 'package:kirana/pages/orders.dart';
import 'package:kirana/widgets/drawer.dart';
import 'package:kirana/widgets/menuitem_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final name = 'CartItems';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer2<CartModel,OrdersListModel>(builder: (context, cart, orderslist, child) {
        List<CartItem> list = [];
        List<MenuItem> itemslist = [];
        cart.items.forEach((k, v) => list.add(CartItem(k)));
        cart.catalog.items.forEach((item) => itemslist.add(MenuItem(item.hashCode)));
        return Scaffold(
          drawer: DrawerPage(),
          appBar: AppBar(
            title: Text("APP_NAME"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                  onTap: () { cart.delete_all();},
                  child: Icon(
                  Icons.delete,
                  size: 26.0,
                  color: Colors.red,
                  ),
               )
               )
               ]),
          body: Container(
            child: CartContents(list, itemslist)
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: <Widget>[
                Text('Total price : ${cart.get_price()}'),
                FlatButton(
                  onPressed:()
                  { 
                    orderslist.create_order(cart);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => OrdersPage()));
                    },
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "checkout",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
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
      }),
      );
  }

  Widget CartContents(List<CartItem> list, List<MenuItem> itemslist){
      if(list.length == 0)
      { 
        return Container(
          child: 
                ListView(children: itemslist),                
        );
      }
      else
      {
        return Container(
          child: ListView(children: list)
          );
      }
  }
}
