import 'package:flutter/foundation.dart';
import 'package:kirana/models/Item.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class ItemsModel extends ChangeNotifier {
  List<Item> _items = [
    Item('SurfExcel 1kg pack super saver pack ', 80, 'dajgdlashkj', 100,
        'images/example.jpeg', 1),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 200, 'images/example.jpeg',
        2),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 300, 'images/example.jpeg',
        3),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 400, 'images/example.jpeg',
        4),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 500, 'images/example.jpeg',
        5),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 600, 'images/example.jpeg',
        6),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 700, 'images/example.jpeg',
        7),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 800, 'images/example.jpeg',
        8),
  ];
  get items => _items;
  Item getItemById(int id) {
    int index = _items.indexWhere((element) => element.hashCode == id);
    return _items[index];
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
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
}
