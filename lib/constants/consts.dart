import 'package:flutter/material.dart';

Color grey = Color(0xff868691);
Color darkGrey = Color(0xff3A3B40);

InputDecoration textFormFieldStyle(String text) {
  return InputDecoration(
    filled: true,
    fillColor: Color(0xFF212121),
    enabledBorder: OutlineInputBorder(
      borderSide: new BorderSide(color: Color(0xff707070), width: 1),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: new BorderSide(color: Color(0xff707070), width: 1),
      borderRadius: BorderRadius.circular(10.0),
    ),
    labelText: text,
    labelStyle: TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
  );
}

TextStyle signUpTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );
}

List<String> cars = [];
String signUpName, signUpEmail, signUpPassword, signUpPhone;
String signInEmail, signInPassword;
String accessToken;

// Meet Local
//final baseUrl = 'http://192.168.43.180:8008';

// Monarch Local
final baseUrl = 'http://192.168.1.18:8008';
