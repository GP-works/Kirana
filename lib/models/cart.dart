import 'package:flutter/foundation.dart';
import 'package:kirana/models/items.dart';

class CartModel extends ChangeNotifier {
  Map _cartitems = new Map();
  ItemsModel _catalog;
  get items => _cartitems;
  // ignore: unnecessary_getters_setters
  get catalog => _catalog;

  void add(String id) {
    if (_cartitems.containsKey(id)) {
      _cartitems[id]++;
    } else {
      _cartitems[id] = 1;
    }
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set catalog(ItemsModel catalog) {
    _catalog = catalog;
  }

  void remove(String id) {
    if (_cartitems[id] == 1) {
      _cartitems.remove(id);
    } else {
      _cartitems[id]--;
    }
    notifyListeners();
  }

  void delete(String id) {
    _cartitems.remove(id);
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  void delete_all() {
    _cartitems = new Map();
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  double get_price() {
    // ignore: non_constant_identifier_names
    double total_price = 0;
    _cartitems.forEach((key, value) {
      total_price = total_price + (value * catalog.getItemById(key).price);
    });
    return total_price;
  }
}
