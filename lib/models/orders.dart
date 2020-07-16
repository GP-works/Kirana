import 'package:flutter/cupertino.dart';
import 'items.dart';

class OrderItem{
  String name;
  double price;
  int id;
  int count;
  String imageurl;

  OrderItem(this.name, this.price, this.id, this.count, this.imageurl);

  @override
  int get hashCode => this.id;

  @override
  bool operator ==(Object other) {
    return other is OrderItem && other.id == id;
  }
}

class OrdersModel{
  List<OrderItem> _orderitems = [];
  int id;
  get items => _orderitems;

  OrderItem getItemById(int id) {
    int index = _orderitems.indexWhere((element) => element.hashCode == id);
    return _orderitems[index];
  }

  void add(OrderItem orderitem) {
    _orderitems.add(orderitem);
    print("added");
  }

  double price()
  {
   double total_price = 0 ;
    _orderitems.forEach((item) => total_price = total_price + item.price);
  }
}