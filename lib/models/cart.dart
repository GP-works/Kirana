import 'package:flutter/foundation.dart';
import 'package:kirana/models/items.dart';

class CartModel extends ChangeNotifier {
  Map _cartitems = new Map();
  ItemsModel _catalog;
  get items => _cartitems;
  get catalog => _catalog;
  void add(int id) {
    if (_cartitems.containsKey(id)) {
      _cartitems[id]++;
    } else {
      _cartitems[id] = 1;
    }
    notifyListeners();
  }

  set catalog(ItemsModel catalog) {
    _catalog = catalog;
  }

  void remove(int id) {
    if (_cartitems[id] == 1) {
      _cartitems.remove(id);
    } else {
      _cartitems[id]--;
    }
    notifyListeners();
  }

  void delete() {
    _cartitems = new Map();
    notifyListeners();
  }
}
