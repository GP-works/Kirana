import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final widget;

  button(this.widget, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: RaisedButton(
              color: Colors.red,
              child: Text("${widget.name}"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget),
                );
              },
            )));
  }
}
