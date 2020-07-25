import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'dart:async';
part 'cart.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

class Orderitems extends Table {
  TextColumn get name => text()();

  RealColumn get price => real()();

  IntColumn get count => integer()();

  TextColumn get shop => text()();

  TextColumn get status => text()();

  TextColumn get imageurl => text()();

  TextColumn get menuitemid => text()();

  TextColumn get userid => text()();
}

@UseMoor(
  tables: [Orderitems],
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Stream<List<Orderitem>> watchCartItems(userid) {
    return (select(orderitems)
          ..where((t) => t.status.equals("cart"))
          ..where((tbl) => tbl.userid.equals(userid))
          ..orderBy([(t) => OrderingTerm(expression: t.menuitemid)]))
        .watch();
  }

  Future<List<String>> getMenuItemIds() async {
    final query = ((selectOnly(orderitems, distinct: true))
          ..where(orderitems.status.equals('cart'))
          ..addColumns([orderitems.menuitemid]))
        .map((row) {
      return row.read(orderitems.menuitemid);
    });
    final list = await query.get();
    return list;
  }

  Future<int> getCount(menuitemid, userid) async {
    final query = await (select(orderitems)
          ..where((tbl) => tbl.status.equals('cart'))
          ..where((tbl) => tbl.userid.equals(userid))
          ..where((t) => t.menuitemid.equals(menuitemid)))
        .get();
    int count = query.length == 0 ? 0 : query.first.count;
    return count;
  }

  Stream<List<String>> getshopids(userid) {
    final query =
        ((selectOnly(orderitems, distinct: true)..where(orderitems.status.equals('cart'))..where(orderitems.userid.equals(userid)))
              ..addColumns([orderitems.shop]))
            .map((row) => row.read(orderitems.shop));
    return query.watch();
  }

  Future<double> getTotalPrice(String shopid, userid) async {
    final query = ((selectOnly(orderitems, distinct: true))
          ..where(orderitems.status.equals('cart'))
          ..where(orderitems.userid.equals(userid))
          ..where(orderitems.shop.equals(shopid))
          ..addColumns([orderitems.price, orderitems.count]))
        .map((row) {
      return row.read(orderitems.price) * row.read(orderitems.count);
    });
    List<double> price = await query.get();
    double sum =
        price.fold(0, (previousValue, element) => previousValue + element);
    return sum;
  }

  Future createEntry(
      {@required String name,
      @required double price,
      @required String shopid,
      @required String menuitemid,
      @required String imageurl,
      @required String userid}) async {
    await into(orderitems).insert(Orderitem(
        name: name,
        price: price,
        count: 1,
        shop: shopid,
        status: "cart",
        menuitemid: menuitemid,
        imageurl: imageurl,
        userid: userid));
  }

  Future incrementItem(menuitemid, count, userid) async {
    return (update(orderitems)
          ..where((tbl) => tbl.userid.equals(userid))
          ..where((t) => t.menuitemid.equals(menuitemid)))
        .write(
      OrderitemsCompanion(
        count: Value(count + 1),
      ),
    );
  }

  Future deleteItem(menuitemid, userid) async {
    return (delete(orderitems)
          ..where((tbl) => tbl.menuitemid.equals(menuitemid))
          ..where((tbl) => tbl.userid.equals(userid)))
        .go();
  }

  Future deleteall(String shopid, userid) async {
    return (delete(orderitems)
          ..where((tbl) => tbl.shop.equals(shopid))
          ..where((tbl) => tbl.userid.equals(userid)))
        .go();
  }

  Future decrementItem(menuitemid, count, userid) async {
    if (count == 1) {
      return (delete(orderitems)
            ..where((tbl) => tbl.menuitemid.equals(menuitemid))
            ..where((tbl) => tbl.userid.equals(userid)))
          .go();
    } else {
      return await (update(orderitems)
            ..where((t) => t.menuitemid.equals(menuitemid))
            ..where((tbl) => tbl.userid.equals(userid)))
          .write(
        OrderitemsCompanion(
          count: Value(count - 1),
        ),
      );
    }
  }

  Future updateItem({name, id, price, imageurl}) async {
    return await (update(orderitems)..where((t) => t.menuitemid.equals(id)))
        .write(
      OrderitemsCompanion(
          name: Value(name), price: Value(price), imageurl: Value(imageurl)),
    );
  }

  Future<List<Orderitem>> getAllItems(String shopid) async {
    return await ((select(orderitems))
          ..where((tbl) => tbl.status.equals('cart'))
          ..where((tbl) => tbl.shop.equals(shopid)))
        .get();
  }

  void updateToOrdered(String menuitemid, userid) async {
    await (update(orderitems)
          ..where((tbl) => tbl.userid.equals(userid))
          ..where((tbl) => tbl.menuitemid.equals(menuitemid)))
        .write(OrderitemsCompanion(status: Value('ordered')));
  }

  @override
  int get schemaVersion => 7;
}
