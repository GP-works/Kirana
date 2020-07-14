import 'package:flutter/foundation.dart';
import 'package:kirana/models/Item.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class ItemsModel extends ChangeNotifier {
  List<Item> _items = [
    Item('SurfExcel 1kg pack super saver pack ', 80, 'dajgdlashkj', 100,
        'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcT0aeFHUBNuVUVB59hp-dwIM02L_ELJWo39qKMG1kwHTt4OORoQbTwIzN7Kvunu0FANl_76ox1adw&usqp=CAc', 1),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 200, 'https://m.media-amazon.com/images/I/61dUCXFgN3L._SS140_.jpg',
        2),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 300, 'https://www.amazon.in/images/I/51KgEYJtvlL._SS140_.jpg',
        3),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 400, 'https://www.amazon.in/images/I/71illy+aC6L._SS140_.jpg',
        4),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 500, 'https://m.media-amazon.com/images/I/71aQtgyXN9L._SS140_.jpg',
        5),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 600, 'https://www.amazon.in/images/I/51y+C6WvBqL._AC_UL246_SR190,246_FMwebp_QL70_.jpg',
        6),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 700, 'https://www.amazon.in/images/I/81ZFWYxDNTL._SS140_.jpg',
        7),
    Item(lipsum.createSentence(), 80, 'dajgdlashkj', 800, 'https://m.media-amazon.com/images/I/61ltYn2nmXL._SS140_.jpg',
        8),
  ];
  get items => _items;
  Item getItemById(int id) {
    int index = _items.indexWhere((element) => element.hashCode == id);
    return _items[index];
  }

  void add(Item item) {
    _items.add(item);
    print("added");
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
