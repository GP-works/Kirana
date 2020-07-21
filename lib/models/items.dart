import 'package:flutter/foundation.dart';
import 'package:kirana/models/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel extends ChangeNotifier {
  String shopownerid;
  List<Item> _items = [];
  get items => _items;

  Item getItemById(String id) {
    int index = _items.indexWhere((element) => element.hashCod == id);
    return _items[index];
  }

  void add(Item item, shopownerid) {
    Firestore.instance
        .collection('shops')
        .document(shopownerid)
        .collection('items')
        .document(item.id)
        .setData(item.toJson());
  }

  void addList(List<Item> items) {
    _items = _items + items;
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  set items(List<Item> newitems) {
    _items = newitems;
    notifyListeners();
  }

  void edititem() {
    notifyListeners();
  }

  bool isEmpty() {
    return _items.isEmpty;
  }

  void addFromFireStore(shopid) {
    if (shopownerid != shopid) {
      _items = [];
      Firestore.instance
          .collection('shops')
          .document(shopid)
          .collection('items')
          .snapshots()
          .listen((data) => data.documents.forEach((doc) {
                _items.add(Item.fromJson(doc));
                notifyListeners();
              }));
      print("getting values from firestore");
      print(_items);
    }
  }
}
