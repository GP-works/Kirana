import 'package:flutter/foundation.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/models/shop.dart';

class CartModel extends ChangeNotifier {
  List<Orderitem> orderitems;
  List<Shop> shops = [];
  CartModel();
  MyDatabase mydb = MyDatabase();
  get items => orderitems;
  // ignore: unnecessary_getters_setters
  Stream<List<Orderitem>> fromf() {
    
    //mydb.watchCartItems().listen((event) { event.forEach((element) {orderitems.add(element);});});
      //        notifyListeners();
      return mydb.watchCartItems();
            }

    Future<int> getcount(String menuitemId) async
    {
      Future<int> cnt;
      cnt = mydb.getCount(menuitemId);
      return cnt;
    }

    void getshopids()
    {
      mydb.getshopids().listen((event) {event.forEach((element) {shops.add(element);});});
      notifyListeners();
    }
    
    void createentry(String name, double price, String shopid, String menuitemid )
    {
      mydb.createEntry(name: name, price: price, shopid: shopid, menuitemid: menuitemid);
      notifyListeners();
    }

    void incrementitem(String menuitemId, int count)
    {
      mydb.incrementItem(menuitemId, count);
      notifyListeners();
    }

    void decrementitem(String menuitemId, int count)
    {
      mydb.decrementItem(menuitemId, count);
      notifyListeners();
    }
    
    void deleteItem(String menuitemId)
    {
      mydb.deleteItem(menuitemId);
      notifyListeners();
    }
    void deleteAll()
    {
      mydb.deleteall();
    }
    double getprice()
    {
      double totalprice = 0;
      orderitems.forEach((element) {totalprice = totalprice + element.price;});
      return totalprice;
    }
}
