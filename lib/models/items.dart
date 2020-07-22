import 'package:flutter/foundation.dart';
import 'package:kirana/models/Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kirana/models/shop.dart';

class ItemsModel extends ChangeNotifier {
  String shopownerid;
  Stream<List<Item>> _items;
  List<Item> itemslist;
  get items => _items;

  Future<Item> getItemById(String id) async {
    List items = await _items.toList();
    int index = items.indexWhere((element) => element.hashCod == id);
    return items[index];
  }

  void add(Item item, shopownerid) {
    Firestore.instance
        .collection('shops')
        .document(shopownerid)
        .collection('items')
        .document(item.id)
        .setData(item.toJson());
  }

  void remove(Item item, String userid) {
    Firestore.instance
        .collection('shops')
        .document(userid)
        .collection('items')
        .document(item.id)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  void edititem() {
    notifyListeners();
  }

  Stream<List<Item>> addFromFireStore(shopid) {
    return Firestore.instance
        .collection('shops')
        .document(shopid)
        .collection('items')
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Item.fromJson(e.data)).toList());
  }
}
