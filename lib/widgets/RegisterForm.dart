import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/widgets/EmailField.dart';
import 'package:kirana/widgets/PhoneNumber.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/Location.dart';
import 'package:kirana/widgets/ImagePicker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:kirana/models/shops.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final Shop shop = Shop();
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _dummyController = TextEditingController();
  final _descriptionController = TextEditingController();
  String imageurl = '';
  File itemimage;
  bool isLoading = false;

  FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImage() async {
    StorageReference reference = _storage.ref().child('images/');
    StorageUploadTask uploadTask = reference
        .child(
            "${_shopNameController.text}${DateTime.now().millisecondsSinceEpoch}")
        .putFile(itemimage);
    if (uploadTask.isComplete) {
      if (uploadTask.isSuccessful) {
        final String url = await reference.getDownloadURL();
        print("The download URL is " + url);
        setState(() {
          imageurl = url;
        });
      } else {
        isLoading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error uploading pic"),
          backgroundColor: Colors.red,
        ));
      }
    } else if (uploadTask.isInProgress) {
      uploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      imageurl = await storageTaskSnapshot.ref.getDownloadURL();

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + imageurl.toString());
    } else {
      isLoading = false;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error uploading pic"),
        backgroundColor: Colors.red,
      ));
      return imageurl;
    }
  }

  @override
  Widget build(BuildContext context) {
    var number = PhoneNumber(_phonenumberController, _dummyController);
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFieldWidgetWithValidation('Shop Name', _shopNameController),
            TextFieldWidgetWithValidation("Owner Name", _ownerNameController),
            number,
            EmailField(_emailController),
            TextFieldWidgetWithValidation(
                'Tell something about your shop', _descriptionController),
            ItemImagePicker(
              notifyParent: setUrl,
              fromEdit: false,
            ),
            !isLoading
                ? Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                        child: RaisedButton(
                          child: Text(
                            "Next".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                          color: Colors.green[700],
                          onPressed: () async {
                            if (_formKey.currentState.validate() &&
                                itemimage != null) {
                              setState(() {
                                isLoading = true;
                              });
                              await uploadImage();
                              if (imageurl == "") {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Upload failed please check internet connection")));
                                isLoading = false;
                                print("setting is loading to false");
                              } else {
                                print(_descriptionController.text);
                                shop.setBasics(
                                    shopName: _shopNameController.text,
                                    ownerName: _ownerNameController.text,
                                    phoneNumber: _dummyController.text,
                                    email: _emailController.text,
                                    description: _descriptionController.text,
                                    imageurl: imageurl);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LocationPage(shop: shop),
                                    ));
                              }
                            } else if (itemimage == null) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("select an image")));
                              isLoading = false;
                            }
                          },
                        )),
                  )
                : CircularProgressIndicator()
          ],
        ));
  }

  void setUrl(File image) {
    setState(() {
      itemimage = image;
      print("image setted");
      if (itemimage == null) {
        print("done");
      }
    });
  }
}
