import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, 5, MediaQuery.of(context).size.width / 10, 10),
        child: IntlPhoneField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(10, 10, 5, 0),
            labelText: "Phone Number",
          ),
          initialCountryCode: "IN",
        ));
  }
}
