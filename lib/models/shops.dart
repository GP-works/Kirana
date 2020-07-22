import 'package:kirana/models/items.dart';
import 'package:kirana/models/shop.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shops extends ChangeNotifier {
  List<Shop> shops = [];
  ItemsModel items = ItemsModel();
  String selectedshopid;
  Shops();
  void fromf() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection('shops').getDocuments();
    snapshot.documentChanges.forEach((element) {
      shops = [];
      shops.add(Shop.fromJson(element.document));
      notifyListeners();
    });
  }

  Shop getShopById(String id) {
    int index = shops.indexWhere((element) => element.getHashCode() == id);
    return shops[index];
  }

  Shop getShopByuserId(String id) {
    int index = shops.indexWhere((element) => element.userid == id);
    return index == -1 ? null : shops[index];
  }

  void add(Shop shop) {
    shops.add(shop);
    print("added");
    notifyListeners();
  }

  void setItems(shopownerid) {
    print(shops);
    selectedshopid = shopownerid;
    items.addFromFireStore(shopownerid);
    print("inside shops");
    print(shops);
    writeshoptoSF(shopownerid);
    notifyListeners();
  }

  void writeshoptoSF(String shopid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("shopid", shopid);
  }

  Future<bool> getfromSF() async {
    if (selectedshopid != null) {
      return true;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String shopid = prefs.getString("shopid");
      notifyListeners();
      if (shopid != null) {
        selectedshopid = shopid;
        notifyListeners();
        print("reading $shopid");
        return true;
      } else {
        return false;
      }
    }
  }
}
