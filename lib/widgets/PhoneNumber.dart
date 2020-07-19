import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  final controller;
  final dummy;
  String number;
  PhoneNumber(this.controller, this.dummy);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, 5, MediaQuery.of(context).size.width / 10, 10),
        child: IntlPhoneField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
            labelText: "Phone Number",
          ),
          onChanged: (value) => dummy.text = value.completeNumber,
          initialCountryCode: "IN",
        ));
  }
}
