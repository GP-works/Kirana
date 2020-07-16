import 'package:flutter/cupertino.dart';
import 'cart.dart';

import 'orders.dart';
class OrdersListModel extends ChangeNotifier{
  List<OrdersModel> orders_list =[];

  get orders => orders_list;

  OrdersModel getItemById(int id) {
    int index = orders_list.indexWhere((element) => element.hashCode == id);
    return orders_list[index];
  }

  void add(OrdersModel order){
    orders_list.add(order);
    notifyListeners();
  }
  
  void create_order(CartModel cart)
  {
    OrdersModel order = new OrdersModel();
    cart.items.forEach((key, value) {
      order.items.add(
      OrderItem(
          cart.catalog.getItemById(key).name,
          cart.catalog.getItemById(key).price,
          DateTime.now().millisecondsSinceEpoch,
          value,
          cart.catalog.getItemById(key).imageurl
          ));
          });
    order.id = DateTime.now().millisecondsSinceEpoch;
    add(order);
    cart.delete_all();
    notifyListeners();
  }
}