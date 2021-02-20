import 'package:drivably_app/Screen/deshboardScreen.dart';
import 'package:drivably_app/Screen/indexScreen.dart';
import 'package:drivably_app/Storage/localStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WapperClass extends StatefulWidget {
  WapperClass({Key key}) : super(key: key);

  @override
  _WapperClassState createState() => _WapperClassState();
}

class _WapperClassState extends State<WapperClass> {
  String _setToken;

  @override
  Widget build(BuildContext context) {
    checkToken().then(
      (token) {
        _setToken = token;
      },
    );
    print(_setToken);
    if (_setToken == null) {
      return IndexScreen();
    } else {
      return DeshboardScreen();
    }
  }
}
