import 'package:kirana/models/shop.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shops extends ChangeNotifier {
  List<Shop> shops = [];
  Shops();
  void fromf() {
    Firestore.instance
        .collection('shops')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              shops.add(Shop.fromJson(doc));
              notifyListeners();
            }));
  }

  Shop getShopById(String id) {
    int index = shops.indexWhere((element) => element.getHashCode() == id);
    return shops[index];
  }

  void add(Shop shop) {
    shops.add(shop);
    print("added");
    notifyListeners();
  }
}
