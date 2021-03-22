import 'dart:io';

import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/screens/dashboard/dashboard.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  String name, age;
  APIServices _services = APIServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Confirm Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(
                  File(widget.imgPath),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String result = await _services.setDriver(widget.imgPath.toString());
          print(result);
          removeUntil(context, DashboardScreen());
          // if(result == '200'){
          // }
          // else{
          // }
        },
        child: Icon(
          Icons.arrow_right,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
