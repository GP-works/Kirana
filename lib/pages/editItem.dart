import 'package:cached_network_image/cached_network_image.dart';
import 'package:kirana/models/items.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/widgets/ImagePicker.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/models/Item.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class editItemPageForm extends StatefulWidget {
  final Item item;
  editItemPageForm(this.item);

  @override
  _editItemPageFormState createState() => _editItemPageFormState();
}

class _editItemPageFormState extends State<editItemPageForm> {
  final name = 'edititems';
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final mrpController = TextEditingController();
  final descriptionController = TextEditingController();
  File itemimage;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    priceController.dispose();
    mrpController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage() async {
    StorageReference reference = _storage.ref().child('images/');
    StorageUploadTask uploadTask = reference
        .child("${nameController.text}${DateTime.now().millisecondsSinceEpoch}")
        .putFile(itemimage);
    if (uploadTask.isSuccessful || uploadTask.isComplete) {
      final String url = await reference.getDownloadURL();
      print("The download URL is " + url);
      setState(() {
        widget.item.imageurl = url;
      });
    } else if (uploadTask.isInProgress) {
      uploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      widget.item.imageurl = await storageTaskSnapshot.ref.getDownloadURL();

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + widget.item.imageurl.toString());
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Error uploading pic"),
        backgroundColor: Colors.red,
      ));
      return widget.item.imageurl;
    }
  }

  @override
  void initState() {
    nameController.text = widget.item.name;
    priceController.text="${widget.item.price}";
    mrpController.text="${widget.item.originalPrice}";
    descriptionController.text=widget.item.description;

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        TextFieldWidgetWithValidation('Name', nameController),
        NumberFieldWidgetWithValidation('price', priceController),
        NumberFieldWidgetWithValidation('original price', mrpController),
        MultilineTextWidgetWithValidation('description', descriptionController),
        Container(
          margin: EdgeInsets.only(bottom: 20, top: 20),
          child: Center(
            child: itemimage == null
                ? CachedNetworkImage(
                    imageUrl: widget.item.imageurl,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    itemimage,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        ItemImagePicker(notifyParent: setUrl, fromEdit: true),
        Container(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: RaisedButton(
                  child: Text(
                    "Submit".toUpperCase(),
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                  color: Colors.green[700],
                  onPressed: () async {
                    if (itemimage != null) {
                      await uploadImage();
                    }
                    if (_formKey.currentState.validate()) {
                      widget.item.name = nameController.text;
                      widget.item.price = double.parse(priceController.text);
                      widget.item.originalPrice =
                          double.parse(mrpController.text);
                      widget.item.description = descriptionController.text;
                      Provider.of<ItemsModel>(context,listen: false).edititem();
                      if (widget.item.imageurl == "") {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("select an image")));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemsPage()));
                      }
                    }
                  })),
        )
      ]),
    );
  }

  void setUrl(File image) {
    setState(() {
      itemimage = image;

    });
  }
  
}
class editItemPage extends StatelessWidget {
  final Item item;
  editItemPage(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit a item"),),
      body: editItemPageForm(item),
    );
  }
}

