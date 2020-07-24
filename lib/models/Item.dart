import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Item {
  String name;
  String description;
  double price;
  double originalPrice;
  String imageurl;
  String id;
  String shopid;

  Item(
    this.name,
    this.price,
    this.description,
    this.originalPrice,
    this.imageurl,
  ) : id = uuid.v1();

  Item.fromJson(data) {
    name = data["name"];
    description = data["description"];
    price = data["price"];
    originalPrice = data["originalPrice"];
    imageurl = data["imageurl"];
    id = data["id"];
    shopid = data["shopid"];
  }

  String get hashCod => this.id;

  @override
  bool operator ==(Object other) {
    return other is Item && other.id == id;
  }

  void update(
      {newname, newprice, newdescription, neworiginalprice, newimageurl}) {
    name = newname;
    price = newprice;
    description = newdescription;
    neworiginalprice = neworiginalprice;
    newimageurl = newimageurl;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "originalPrice": originalPrice,
      "imageurl": imageurl,
      "id": id,
      "shopid": shopid,
      "updatedat": DateTime.now().millisecondsSinceEpoch
    };
  }
}
