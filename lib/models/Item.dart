import 'package:flutter/foundation.dart';

@immutable
class Item {
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String imageurl;
  final bool edit;
  final int id;
  Item(this.name, this.price, this.description, this.originalPrice,
      this.imageurl,
      this.id,
      {this.edit });
  @override
  // TODO: implement hashCode
  int get hashCode => this.id;

  @override
  bool operator ==(Object other) {
    return other is Item && other.id == id;
  }
}
