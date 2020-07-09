import 'package:flutter/material.dart';

class TextNewUser extends StatefulWidget {
  @override
  _TextNewUserState createState() => _TextNewUserState();
}

class _TextNewUserState extends State<TextNewUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 10),
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
            ),
            Center(
              child: Text(
                'We can start something new',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
