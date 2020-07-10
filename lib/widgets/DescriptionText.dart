import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  var text;
  DescriptionText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                ),
            )
          ],
          ),
    );
  }
}