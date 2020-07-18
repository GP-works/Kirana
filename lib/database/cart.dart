import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'cart.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

class Orderitems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get price => real()();

  IntColumn get count => integer()();

  TextColumn get shop => text()();

  TextColumn get status => text()();

  TextColumn get menuitemid => text()();
}

@UseMoor(tables: [Orderitems])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  Stream<List<Orderitem>> watchCartItems() {
    list= (select(orderitems)..where((t) => t.status.equals("cart"))..orderBy([(t) => OrderingTerm(expression: t.menuitemid)])).watch();
  }

  int getCount(menuitemid)
  {
    final query= (select(orderitems)..where((t) => t.menuitemid.equals(menuitemid)));
  }


  @override
  int get schemaVersion => 4;
}
