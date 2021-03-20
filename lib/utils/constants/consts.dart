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

Card makeDashboardItem(String title, IconData icon) {
  return Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: new InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                  child: Icon(
                icon,
                size: 40.0,
                color: Colors.black,
              )),
              SizedBox(height: 20.0),
              new Center(
                child: new Text(title,
                    style: new TextStyle(fontSize: 18.0, color: Colors.black)),
              )
            ],
          ),
        ),
      ));
}

showPassword(bool pswdState) {
  if (pswdState == true) {}
}

List<String> driverEmail = [];
List<String> tempDriverEmail = [];
List<String> tempUserData = [];
List<String> carData = [];

String signUpName,
    signUpEmail,
    signUpPassword,
    signUpConfirmPassword,
    signUpPhoneNumber;
String signInEmail, signInPassword;
String accessToken;

String setLicense;

//  Meet Local
final baseUrl = 'http://192.168.43.180:8008';

// Aditya Local
// final baseUrl = "http://192.168.1.9:8008";
List<String> driversList;

// MapBox Access Token
// ignore: non_constant_identifier_names
final String ACCESS_TOKEN =
    "pk.eyJ1IjoiYmxhY2tkZXZpbDk4IiwiYSI6ImNrNGpxY3BmODBjbHQzam1sbTBuaWh1MDcifQ.tR35Ox0EonGORTdc83r_Nw";
