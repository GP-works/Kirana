import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  var text;
  DescriptionText(this.text);
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
                '$text',
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