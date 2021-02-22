import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/screens/wrapper/wrapperClass.dart';
import 'package:drivably_app/utils/storage/localStorage.dart';
import 'package:flutter/material.dart';

class MapScreeen extends StatelessWidget {
  const MapScreeen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("xx 00 xx 0000"),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              removeToken();
              removeUntil(context, WrapperClass());
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
