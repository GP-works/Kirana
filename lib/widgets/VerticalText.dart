import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  var text;
  VerticalText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
              quarterTurns: -1,
              child: Text(
              '$text',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w900,
              ),
              ),
              ),
    );
  }
}