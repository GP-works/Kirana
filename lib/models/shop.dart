import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kirana/models/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
FirebaseAuth _auth = FirebaseAuth.instance;

class Shop {
  String id;
  String _shopName;
  String _ownerName;
  String _phoneNumber;
  String _email;
  ItemsModel items = ItemsModel();
  double _latitude;
  double _longitude;
  String _adressLane1;
  String _adressLane2;
  int _pincode;
  String userid;

  Shop(
      {double latitude,
      double longitude,
      adressLane1,
      pincode,
      adressLane2,
      String shopName,
      String ownerName,
      String phoneNumber,
      String email});

  Shop.fromJson(doc) {
    id = doc["id"];
    userid = doc["userid"];
    _shopName = doc["shopName"];
    _ownerName = doc["ownerName"];
    _phoneNumber = doc["phoneNumber"];
    _email = doc["email"];
    _latitude = doc["latitude"];
    _longitude = doc["longitude"];
    _adressLane1 = doc["address1"];
    _adressLane2 = doc["address2"];
    _pincode = doc["pincode"];
  }
  String getHashCode() => this.id;
  get name => "$_shopName";
  get owner => "$_ownerName";
  get address => "$_adressLane1,$_adressLane2";
  Future<bool> setPosition(
      {@required double latitude,
      @required double longitude,
      @required adressLane1,
      @required pincode,
      @required adressLane2}) async {
    _latitude = latitude;
    _longitude = longitude;
    _adressLane1 = adressLane1;
    _adressLane2 = adressLane2;
    _pincode = int.parse(pincode);
    userid = await _auth.currentUser().then((value) => value.uid);

    String msg = await uploadToFirestore();
    return msg == 'true';
  }

  void setBasics(
      {@required String shopName,
      @required String ownerName,
      @required String phoneNumber,
      @required String email}) {
    _shopName = shopName;
    _ownerName = ownerName;
    _phoneNumber = phoneNumber;
    _email = email;
    id = uuid.v1();
  }

  Future uploadToFirestore() async {
    try {
      final CollectionReference _shopsCollectionReference =
          Firestore.instance.collection("shops");
      await _shopsCollectionReference.document(userid).setData(toJson());
      return "true";
    } catch (e) {
      return e.message;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userid": userid,
      "accepted": false,
      'shopName': _shopName,
      'ownerName': _ownerName,
      'phoneNumber': _phoneNumber,
      'email': _email,
      'latitude': _latitude,
      "longitude": _longitude,
      "address1": _adressLane1,
      "address2": _adressLane2,
      "pincode": _pincode
    };
  }
}
