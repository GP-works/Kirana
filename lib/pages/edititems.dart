import 'package:flutter/material.dart';
import 'package:kirana/widgets/ImagePicker.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';

class EditItemsPage extends StatelessWidget {
  final name = 'edititems';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("EditItems")),
        body: Form(
          key: _formKey,
          child: ListView(children: [
            TextFieldWidgetWithValidation('Name'),
            NumberFieldWidgetWithValidation('price'),
            NumberFieldWidgetWithValidation('original price'),
            MultilineTextWidgetWithValidation('description'),
            ItemImagePicker(),
          ]),
        ));
  }
}
