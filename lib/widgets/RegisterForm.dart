import 'package:flutter/material.dart';
import 'package:kirana/models/shop.dart';
import 'package:kirana/widgets/EmailField.dart';
import 'package:kirana/widgets/PhoneNumber.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/Location.dart';
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
                        print(_dummyController.text);
                        shop.setBasics(
                            shopName: _shopNameController.text,
                            ownerName: _ownerNameController.text,
                            phoneNumber: _dummyController.text,
                            email: _emailController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Location(shop: shop),
                            ));
                      }
                    },
                  )),
            )
          ],
        ));
  }
}
