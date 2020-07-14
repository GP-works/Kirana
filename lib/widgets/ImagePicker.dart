import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ItemImagePicker extends StatefulWidget {
  final void Function(String url) notifyParent;

  ItemImagePicker({Key key, @required this.notifyParent}) : super(key: key);

  @override
  _ItemImagePickerState createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  File image;
  String url = "";
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 400, maxWidth: 400);
    setState(() {
      image = File(pickedFile.path);
      print(image.lengthSync());
      uploadPic();
    });
  }

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPic() async {
    StorageReference reference = _storage.ref().child('images/');
    StorageUploadTask uploadTask = reference.child('image1').putFile(image);
    if (uploadTask.isSuccessful || uploadTask.isComplete) {
      final String url = await reference.getDownloadURL();
      print("The download URL is " + url);
      widget.notifyParent(url);
    } else if (uploadTask.isInProgress) {
      uploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      url = await storageTaskSnapshot.ref.getDownloadURL();
      widget.notifyParent(url);

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + url.toString());
    } else {
      url = "";
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    String text = url == "" ? "Add Photo" : "Change Photo";
    return Column(
      children: <Widget>[
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
        ),
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
