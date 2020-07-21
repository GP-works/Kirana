import 'package:flutter/material.dart';
import 'package:kirana/models/user.dart';
import 'package:provider/provider.dart';

class SignOut extends StatelessWidget {
  final name;
  SignOut(this.name,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: RaisedButton(
      color: Colors.red,
      child: Text("$name Signout"),
      onPressed: () {
        Provider.of<User>(context, listen: false).signout(context);
      },
    )));
  }
}
