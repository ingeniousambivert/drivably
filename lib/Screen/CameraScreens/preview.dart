import 'dart:io';

import 'package:drivably_app/Module/const.dart';
import 'package:drivably_app/Module/routing.dart';
import 'package:drivably_app/Screen/deshboardScreen.dart';
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
              SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textFormFieldStyle("Driver's Name"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textFormFieldStyle("Driver's Age"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('here now');
          print(widget.imgPath);
          print(name + " " + age);
          pushToNext(context, DeshboardScreen());

          // getBytes().then((bytes) {

          //   print(bytes.buffer.asUint8List());
          //   Share.file('Share via', widget.fileName,
          //       bytes.buffer.asUint8List(), 'image/path');
          // },
          //);
        },
        child: Icon(
          Icons.arrow_right,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

//   Future getBytes () async {
//     Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
// //    print(ByteData.view(buffer))
//     return ByteData.view(bytes.buffer);
//   }
}
