import 'package:flutter/foundation.dart';
import 'package:kirana/models/Item.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class ItemsModel extends ChangeNotifier {
  List<Item> _items =[ Item('SurfExcel 1kg pack super saver pack ', 80,
      'dajgdlashkj', 100, 'images/example.jpeg'),
      Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  Item(lipsum.createSentence(), 80,
  'dajgdlashkj', 100, 'images/example.jpeg'),
  ];
  get items =>_items;
  Item getById(int id) => _items[id];
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
  void addList(List<Item> items)
  {
    _items = _items+items;
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
  set items(List<Item> newitems){
    _items=newitems;
    notifyListeners();
  }


}

