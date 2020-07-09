import 'package:flutter/material.dart';

class VerticalTextSignUp extends StatefulWidget {
  @override
  _VerticalTextSignUpState createState() => _VerticalTextSignUpState();
}

class _VerticalTextSignUpState extends State<VerticalTextSignUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(
          'Sign Up',
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
