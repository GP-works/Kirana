import 'package:flutter/material.dart';
import 'package:kirana/models/items.dart';
import 'package:kirana/pages/items.dart';
import 'package:kirana/widgets/ImagePicker.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/models/Item.dart';
import 'package:provider/provider.dart';

class EditItemsPageForm extends StatefulWidget {
  @override
  _EditItemsPageFormState createState() => _EditItemsPageFormState();
}

class _EditItemsPageFormState extends State<EditItemsPageForm> {
  final name = 'edititems';
  final _formKey = GlobalKey<FormState>();
  String itemname;
  String description;
  double price;
  double originalPrice;
  String imageurl = '';
  int id;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final mrpController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    priceController.dispose();
    mrpController.dispose();
    descriptionController.dispose();
    super.dispose();
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
        ItemImagePicker(notifyParent: setUrl),
        Container(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: RaisedButton(
                  child: Text(
                    "Next".toUpperCase(),
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                  color: Colors.green[700],
                  onPressed: () {
                      if (_formKey.currentState.validate()) {
                        itemname = nameController.text;
                        price = double.parse(priceController.text);
                        originalPrice = double.parse(mrpController.text);
                        description = descriptionController.text;
                        id = new DateTime.now().millisecondsSinceEpoch;
                        if (imageurl == "") {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("select an image")));}
                        else {
                          _additem_to_container();

                          Navigator.push(
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

  void setUrl(String url) {
    setState(() {
      imageurl = url;
    });
  }

  void _additem_to_container() {
    var catalog = Provider.of<ItemsModel>(context,listen: false);
    catalog
        .add(Item(itemname, price, description, originalPrice, imageurl, id));
  }
}

class EditItemsPage extends StatelessWidget {
  final name = "edit items";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit items",
        ),
      ),
      body: EditItemsPageForm(),
    );
  }
}
