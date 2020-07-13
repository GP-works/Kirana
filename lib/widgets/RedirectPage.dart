import 'package:flutter/material.dart';

class RedirectPage extends StatelessWidget {
  final Widget widget;
  final String text;
  final String description;
  RedirectPage(this.widget, this.text, this.description, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              '$description',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => widget));
              },
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
