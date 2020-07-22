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
    cart.items.forEach((orderitem) async{
      order.items.add (
      OrderItem ( 
          orderitem.name,
          orderitem.price,
          DateTime.now().millisecondsSinceEpoch,
          await cart.getcount(orderitem.menuitemid),
          'https://m.media-amazon.com/images/I/71aQtgyXN9L._SS140_.jpg'
          ));
          });
    order.id = DateTime.now().millisecondsSinceEpoch;
    add(order);
    cart.deleteAll();
    notifyListeners();
  }
}