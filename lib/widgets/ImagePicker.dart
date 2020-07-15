import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class ItemImagePicker extends StatefulWidget {
  final void Function(File image) notifyParent;
  final bool fromEdit;

  ItemImagePicker({Key key, @required this.notifyParent,this.fromEdit}) : super(key: key);
  @override
  _ItemImagePickerState createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  File image;
  String url = "";
  final picker = ImagePicker();
  String texts="Oldimage";

  Future getImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 400, maxWidth: 400);
    setState(() {
      image = File(pickedFile.path);
      widget.notifyParent(image);
      texts = "new image added";
    });

  }

  @override
  Widget build(BuildContext context) {
    String text = image==null ? "Add Photo" : "Change Photo";
    if(widget.fromEdit)
      {
        text = "Change Photo";
      }
    return Column(
      children: <Widget>[
        (!widget.fromEdit)?
        Container(
          margin: EdgeInsets.only(bottom: 20, top: 20),
          child: Center(
            child: image == null
                ? Text('No Image selected')
                : Image.file(
                    image,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
          ),
        ): Center(child: Text("$texts")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                "$text",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              FlatButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Row(children: [
                  Text('Gallery'),
                  Icon(Icons.add_photo_alternate),
                ]),
              ),
              FlatButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Row(children: [
                    Text('Camera'),
                    Icon(Icons.add_a_photo),
                  ])),
            ],
          ),
        )
      ],
    );
  }
}
