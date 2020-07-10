import 'package:flutter/material.dart';
import 'package:kirana/widgets/EmailField.dart';
import 'package:kirana/widgets/PhoneNumber.dart';
import 'package:kirana/widgets/TextFieldWidget.dart';
import 'package:kirana/pages/Location.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFieldWidgetWithValidation('Shop Name'),
            TextFieldWidgetWithValidation("Owner Name"),
            PhoneNumber(),
            EmailField(),
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
                      //if (_formKey.currentState.validate())
                      // Scaffold.of(context).showSnackBar(
                      //  SnackBar(content: Text("valid processing")));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Location(),
                          ));
                    },
                  )),
            )
          ],
        ));
  }
}
