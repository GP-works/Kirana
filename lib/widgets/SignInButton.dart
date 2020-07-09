import 'package:flutter/material.dart';

class SigninButton extends StatefulWidget {
  @override
  _SigninButtonState createState() => _SigninButtonState();
}

class _SigninButtonState extends State<SigninButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(
                5,
                5
              )
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: FlatButton(
          onPressed:(){
            Navigator.pop(context);
           },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}