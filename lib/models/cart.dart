import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kirana/database/cart.dart';
import 'package:kirana/models/Item.dart';
import 'package:kirana/models/shops.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class CartModel extends ChangeNotifier {
  List<Orderitem> orderitems;
  List<String> shops = [];
  CartModel();
  MyDatabase mydb = MyDatabase();
  List<String> menuitemids;
  int lastupdated;
  get items => orderitems;
  // ignore: unnecessary_getters_setters
  Stream<List<Orderitem>> fromf(String userid) {
    //mydb.watchCartItems().listen((event) { event.forEach((element) {orderitems.add(element);});});
    //        notifyListeners();
    return mydb.watchCartItems(userid);
  }

  Future<int> getcount(String menuitemId, String userid) async {
    Future<int> cnt;
    cnt = mydb.getCount(menuitemId, userid);
    return cnt;
  }

  Future<double> getTotalprice(String shopId, String userid) async {
    return await mydb.getTotalPrice(shopId, userid);
  }

  Stream<List<String>> updateShops(userid) {
    return mydb.getshopids(userid);
  }

  void createentry(String name, double price, String shopid, String menuitemid,
      String imageurl, String userid) {
    mydb.createEntry(
        name: name,
        price: price,
        shopid: shopid,
        menuitemid: menuitemid,
        imageurl: imageurl,
        userid: userid);
    notifyListeners();
  }

  void incrementitem(String menuitemId, int count, String userid) {
    mydb.incrementItem(menuitemId, count, userid);
    notifyListeners();
  }

  void decrementitem(String menuitemId, int count, String userid) {
    mydb.decrementItem(menuitemId, count, userid);
    notifyListeners();
  }

  void deleteItem(String menuitemId, String userid) {
    mydb.deleteItem(menuitemId, userid);
    notifyListeners();
  }

  void deleteAll(String shopid, String userid) {
    mydb.deleteall(shopid, userid);
  }

  void update(Item item) {
    mydb.updateItem(
        name: item.name,
        price: item.price,
        id: item.id,
        imageurl: item.imageurl);
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
      Query query = Firestore.instance
          .collectionGroup('items')
          .where("id", whereIn: sublist)
          .where('updatedat', isGreaterThan: prefs.getInt('lastupdated'));
      print(query.buildArguments());
      QuerySnapshot snapshot = await query.getDocuments();
      snapshot.documents.forEach((element) {
        update(Item.fromJson(element.data));
        print(element.data);
        notifyListeners();
      });
      for (i = length % 10; i < length; length += 10) {
        List<String> sublist = menuitemids.sublist(i, i + 10);
        QuerySnapshot snapshot = await Firestore.instance
            .collectionGroup('items')
            .where('id', whereIn: sublist)
            .where('updatedat', isGreaterThan: prefs.getInt('lastupdated'))
            .getDocuments();
        snapshot.documents.forEach((element) {
          update(Item.fromJson(element.data));
          notifyListeners();
          print(sublist);
        });
      }
    }
    WritetoSf();
  }

  void create_order(shopid, User user) async {
    List<Orderitem> orderitems = await mydb.getAllItems(shopid);
    String unique = uuid.v1();
    Firestore.instance.collection('orders').document(unique).setData({
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'status': 'ordered',
      'shopid': shopid,
      'remarks': "no",
      'userid': user.uid,
      'userName': user.name,
      'price': await getTotalprice(shopid, user.uid)
    });
    orderitems.forEach((element) {
      Firestore.instance
          .collection('orders')
          .document(unique)
          .collection('orderitems')
          .document(element.menuitemid)
          .setData(element.toJson());
      mydb.updateToOrdered(element.menuitemid, user.uid);
    });
  }
}
