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

  TextColumn get menuitemid => text().customConstraint('UNIQUE')();
}

@UseMoor(
  tables: [Orderitems],
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Stream<List<Orderitem>> watchCartItems() {
    return (select(orderitems)
          ..where((t) => t.status.equals("cart"))
          ..orderBy([(t) => OrderingTerm(expression: t.menuitemid)]))
        .watch();
  }

  Future<int> getCount(menuitemid) async {
    final query = await (select(orderitems)
          ..where((t) => t.menuitemid.equals(menuitemid)))
        .get();
    return query.length == 0 ? 0 : query.first.count;
  }

  Stream<List<dynamic>> getshopids() {
    final query = (selectOnly(orderitems, distinct: true))
      ..addColumns([orderitems.shop]);
    return query.watch();
  }

  Future createEntry(
      {@required String name,
      @required double price,
      @required String shopid,
      @required String menuitemid}) async {
    await into(orderitems).insert(Orderitem(
        name: name,
        price: price,
        count: 1,
        shop: shopid,
        status: "cart",
        menuitemid: menuitemid));
  }

  Future incrementItem(menuitemid, count) async {
    return (update(orderitems)..where((t) => t.menuitemid.equals(menuitemid)))
        .write(
      OrderitemsCompanion(
        count: Value(count + 1),
      ),
    );
  }

  Future deleteItem(menuitemid) async
  {
    return delete(orderitems)
        ..where((tbl) => tbl.menuitemid.equals(menuitemid));
  }

  Future deleteall() async{
    return delete(orderitems);
  }

  Future decrementItem(menuitemid, count) async {
    if (count == 0) {
      return delete(orderitems)
        ..where((tbl) => tbl.menuitemid.equals(menuitemid));
    } else {
      return await (update(orderitems)
            ..where((t) => t.menuitemid.equals(menuitemid)))
          .write(
        OrderitemsCompanion(
          count: Value(count - 1),
        ),
      );
    }
  }

  @override
  int get schemaVersion => 6;
}
