// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Orderitem extends DataClass implements Insertable<Orderitem> {
  final String name;
  final double price;
  final int count;
  final String shop;
  final String status;
  final String imageurl;
  final String menuitemid;
  final String userid;
  Orderitem(
      {@required this.name,
      @required this.price,
      @required this.count,
      @required this.shop,
      @required this.status,
      @required this.imageurl,
      @required this.menuitemid,
      @required this.userid});
  factory Orderitem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return Orderitem(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      count: intType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
      shop: stringType.mapFromDatabaseResponse(data['${effectivePrefix}shop']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      imageurl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}imageurl']),
      menuitemid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}menuitemid']),
      userid:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}userid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || shop != null) {
      map['shop'] = Variable<String>(shop);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || imageurl != null) {
      map['imageurl'] = Variable<String>(imageurl);
    }
    if (!nullToAbsent || menuitemid != null) {
      map['menuitemid'] = Variable<String>(menuitemid);
    }
    if (!nullToAbsent || userid != null) {
      map['userid'] = Variable<String>(userid);
    }
    return map;
  }

  OrderitemsCompanion toCompanion(bool nullToAbsent) {
    return OrderitemsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      shop: shop == null && nullToAbsent ? const Value.absent() : Value(shop),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      imageurl: imageurl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageurl),
      menuitemid: menuitemid == null && nullToAbsent
          ? const Value.absent()
          : Value(menuitemid),
      userid:
          userid == null && nullToAbsent ? const Value.absent() : Value(userid),
    );
  }

  factory Orderitem.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Orderitem(
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      count: serializer.fromJson<int>(json['count']),
      shop: serializer.fromJson<String>(json['shop']),
      status: serializer.fromJson<String>(json['status']),
      imageurl: serializer.fromJson<String>(json['imageurl']),
      menuitemid: serializer.fromJson<String>(json['menuitemid']),
      userid: serializer.fromJson<String>(json['userid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'count': serializer.toJson<int>(count),
      'shop': serializer.toJson<String>(shop),
      'status': serializer.toJson<String>(status),
      'imageurl': serializer.toJson<String>(imageurl),
      'menuitemid': serializer.toJson<String>(menuitemid),
      'userid': serializer.toJson<String>(userid),
    };
  }

  Orderitem copyWith(
          {String name,
          double price,
          int count,
          String shop,
          String status,
          String imageurl,
          String menuitemid,
          String userid}) =>
      Orderitem(
        name: name ?? this.name,
        price: price ?? this.price,
        count: count ?? this.count,
        shop: shop ?? this.shop,
        status: status ?? this.status,
        imageurl: imageurl ?? this.imageurl,
        menuitemid: menuitemid ?? this.menuitemid,
        userid: userid ?? this.userid,
      );
  @override
  String toString() {
    return (StringBuffer('Orderitem(')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('shop: $shop, ')
          ..write('status: $status, ')
          ..write('imageurl: $imageurl, ')
          ..write('menuitemid: $menuitemid, ')
          ..write('userid: $userid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          price.hashCode,
          $mrjc(
              count.hashCode,
              $mrjc(
                  shop.hashCode,
                  $mrjc(
                      status.hashCode,
                      $mrjc(imageurl.hashCode,
                          $mrjc(menuitemid.hashCode, userid.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Orderitem &&
          other.name == this.name &&
          other.price == this.price &&
          other.count == this.count &&
          other.shop == this.shop &&
          other.status == this.status &&
          other.imageurl == this.imageurl &&
          other.menuitemid == this.menuitemid &&
          other.userid == this.userid);
}

class OrderitemsCompanion extends UpdateCompanion<Orderitem> {
  final Value<String> name;
  final Value<double> price;
  final Value<int> count;
  final Value<String> shop;
  final Value<String> status;
  final Value<String> imageurl;
  final Value<String> menuitemid;
  final Value<String> userid;
  const OrderitemsCompanion({
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.count = const Value.absent(),
    this.shop = const Value.absent(),
    this.status = const Value.absent(),
    this.imageurl = const Value.absent(),
    this.menuitemid = const Value.absent(),
    this.userid = const Value.absent(),
  });
  OrderitemsCompanion.insert({
    @required String name,
    @required double price,
    @required int count,
    @required String shop,
    @required String status,
    @required String imageurl,
    @required String menuitemid,
    @required String userid,
  })  : name = Value(name),
        price = Value(price),
        count = Value(count),
        shop = Value(shop),
        status = Value(status),
        imageurl = Value(imageurl),
        menuitemid = Value(menuitemid),
        userid = Value(userid);
  static Insertable<Orderitem> custom({
    Expression<String> name,
    Expression<double> price,
    Expression<int> count,
    Expression<String> shop,
    Expression<String> status,
    Expression<String> imageurl,
    Expression<String> menuitemid,
    Expression<String> userid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (count != null) 'count': count,
      if (shop != null) 'shop': shop,
      if (status != null) 'status': status,
      if (imageurl != null) 'imageurl': imageurl,
      if (menuitemid != null) 'menuitemid': menuitemid,
      if (userid != null) 'userid': userid,
    });
  }

  OrderitemsCompanion copyWith(
      {Value<String> name,
      Value<double> price,
      Value<int> count,
      Value<String> shop,
      Value<String> status,
      Value<String> imageurl,
      Value<String> menuitemid,
      Value<String> userid}) {
    return OrderitemsCompanion(
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      shop: shop ?? this.shop,
      status: status ?? this.status,
      imageurl: imageurl ?? this.imageurl,
      menuitemid: menuitemid ?? this.menuitemid,
      userid: userid ?? this.userid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (shop.present) {
      map['shop'] = Variable<String>(shop.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (imageurl.present) {
      map['imageurl'] = Variable<String>(imageurl.value);
    }
    if (menuitemid.present) {
      map['menuitemid'] = Variable<String>(menuitemid.value);
    }
    if (userid.present) {
      map['userid'] = Variable<String>(userid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderitemsCompanion(')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('shop: $shop, ')
          ..write('status: $status, ')
          ..write('imageurl: $imageurl, ')
          ..write('menuitemid: $menuitemid, ')
          ..write('userid: $userid')
          ..write(')'))
        .toString();
  }
}

class $OrderitemsTable extends Orderitems
    with TableInfo<$OrderitemsTable, Orderitem> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrderitemsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedRealColumn _price;
  @override
  GeneratedRealColumn get price => _price ??= _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'count',
      $tableName,
      false,
    );
  }

  final VerificationMeta _shopMeta = const VerificationMeta('shop');
  GeneratedTextColumn _shop;
  @override
  GeneratedTextColumn get shop => _shop ??= _constructShop();
  GeneratedTextColumn _constructShop() {
    return GeneratedTextColumn(
      'shop',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageurlMeta = const VerificationMeta('imageurl');
  GeneratedTextColumn _imageurl;
  @override
  GeneratedTextColumn get imageurl => _imageurl ??= _constructImageurl();
  GeneratedTextColumn _constructImageurl() {
    return GeneratedTextColumn(
      'imageurl',
      $tableName,
      false,
    );
  }

  final VerificationMeta _menuitemidMeta = const VerificationMeta('menuitemid');
  GeneratedTextColumn _menuitemid;
  @override
  GeneratedTextColumn get menuitemid => _menuitemid ??= _constructMenuitemid();
  GeneratedTextColumn _constructMenuitemid() {
    return GeneratedTextColumn(
      'menuitemid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useridMeta = const VerificationMeta('userid');
  GeneratedTextColumn _userid;
  @override
  GeneratedTextColumn get userid => _userid ??= _constructUserid();
  GeneratedTextColumn _constructUserid() {
    return GeneratedTextColumn(
      'userid',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, price, count, shop, status, imageurl, menuitemid, userid];
  @override
  $OrderitemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'orderitems';
  @override
  final String actualTableName = 'orderitems';
  @override
  VerificationContext validateIntegrity(Insertable<Orderitem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count'], _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('shop')) {
      context.handle(
          _shopMeta, shop.isAcceptableOrUnknown(data['shop'], _shopMeta));
    } else if (isInserting) {
      context.missing(_shopMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('imageurl')) {
      context.handle(_imageurlMeta,
          imageurl.isAcceptableOrUnknown(data['imageurl'], _imageurlMeta));
    } else if (isInserting) {
      context.missing(_imageurlMeta);
    }
    if (data.containsKey('menuitemid')) {
      context.handle(
          _menuitemidMeta,
          menuitemid.isAcceptableOrUnknown(
              data['menuitemid'], _menuitemidMeta));
    } else if (isInserting) {
      context.missing(_menuitemidMeta);
    }
    if (data.containsKey('userid')) {
      context.handle(_useridMeta,
          userid.isAcceptableOrUnknown(data['userid'], _useridMeta));
    } else if (isInserting) {
      context.missing(_useridMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Orderitem map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Orderitem.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OrderitemsTable createAlias(String alias) {
    return $OrderitemsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $OrderitemsTable _orderitems;
  $OrderitemsTable get orderitems => _orderitems ??= $OrderitemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [orderitems];
}
