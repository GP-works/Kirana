import 'package:kirana/models/shop.dart';
import 'package:flutter/foundation.dart';

class Shops extends ChangeNotifier {
  List<Shop> shops = [];

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
