class Item {
  String name;
  String description;
  double price;
  double originalPrice;
  String imageurl;
  bool edit;
  int id;

  Item(this.name, this.price, this.description, this.originalPrice,
      this.imageurl, this.id,
      {this.edit});

  @override
  int get hashCode => this.id;

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
}
