import 'package:flutter/material.dart';
import 'package:kirana/widgets/EmailField.dart';

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
          children: <Widget>[EmailField(),

            Container(
              alignment: Alignment.bottomCenter,

              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: RaisedButton(child: Text("submit".toUpperCase(),style: TextStyle(color: Colors.white,letterSpacing: 1),),
                    color: Colors.green[700],
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("valid processing")));
                    },)
              )
              ,)
          ],)
    );
  }

}
