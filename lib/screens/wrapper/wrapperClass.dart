import 'package:drivably_app/screens/dashboard/dashboard.dart';
import 'package:drivably_app/screens/index.dart';
import 'package:drivably_app/utils/storage/localStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WrapperClass extends StatefulWidget {
  WrapperClass({Key key}) : super(key: key);

  @override
  _WrapperClassState createState() => _WrapperClassState();
}

class _WrapperClassState extends State<WrapperClass> {
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
      return DashboardScreen();
    }
  }
}
