import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/orders.dart';
import 'package:kirana/models/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel extends ChangeNotifier {
  List<Orderitem> orderitems;
  List<Shop> shops = [];
  CartModel();
  MyDatabase mydb = MyDatabase();
  List<String> menuitemids;
  int lastupdated;
  get items => orderitems;
  // ignore: unnecessary_getters_setters
  Stream<List<Orderitem>> fromf() {
    //mydb.watchCartItems().listen((event) { event.forEach((element) {orderitems.add(element);});});
    //        notifyListeners();
    return mydb.watchCartItems();
  }

  Future<int> getcount(String menuitemId) async {
    Future<int> cnt;
    cnt = mydb.getCount(menuitemId);
    return cnt;
  }

  void getshopids() {
    mydb.getshopids().listen((event) {
      event.forEach((element) {
        shops.add(element);
      });
    });
    notifyListeners();
  }

  void createentry(String name, double price, String shopid, String menuitemid,
      String imageurl) {
    mydb.createEntry(
        name: name,
        price: price,
        shopid: shopid,
        menuitemid: menuitemid,
        imageurl: imageurl);
    notifyListeners();
  }

  void incrementitem(String menuitemId, int count) {
    mydb.incrementItem(menuitemId, count);
    notifyListeners();
  }

  void decrementitem(String menuitemId, int count) {
    mydb.decrementItem(menuitemId, count);
    notifyListeners();
  }

  void deleteItem(String menuitemId) {
    mydb.deleteItem(menuitemId);
    notifyListeners();
  }

  void deleteAll() {
    mydb.deleteall();
  }

  void update(Item item) {
    mydb.updateItem(
        name: item.name,
        price: item.price,
        id: item.id,
        imageurl: item.imageurl);
  }

  double getprice(List<Orderitem> orderitems) {
    double totalprice = 0;
    orderitems.forEach((element) {
      totalprice = totalprice + element.price;
    });
    return totalprice;
  }

  void readFromSF() async {
    lastupdated = await SharedPreferences.getInstance()
        .then((value) => value.getInt('lastupdated'));
  }

  void WritetoSf() {
    SharedPreferences.getInstance().then((value) =>
        value.setInt('lastupdated', DateTime.now().millisecondsSinceEpoch));
  }

  void getmenuitemids() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    menuitemids = await mydb.getMenuItemIds();
    int length = menuitemids.length;
    if (length > 0) {
      int i;
      List<String> sublist = menuitemids.sublist(0, length % 10);
      print(sublist);
      Query query =  Firestore.instance
          .collectionGroup('items')
          .where("id", whereIn: sublist)
          .where('updatedat', isGreaterThan: prefs.getInt('lastupdated'));
      print(query.buildArguments());
        QuerySnapshot snapshot=await query.getDocuments();
      snapshot.documents.forEach((element) {
        update(Item.fromJson(element.data));
        print(element.data);
        notifyListeners();
      });
      for (i = length % 10; i < length; length+=10) {
        List<String> sublist = menuitemids.sublist(i, i  + 10);
        QuerySnapshot snapshot = await Firestore.instance
            .collectionGroup('items')
            .where('id', whereIn: sublist).
            where('updatedat', isGreaterThan: prefs.getInt('lastupdated')).getDocuments();
        snapshot.documents.forEach((element) {
          update(Item.fromJson(element.data));
          notifyListeners();
          print(sublist);
        });
      }
    }
    WritetoSf();
  }
}
