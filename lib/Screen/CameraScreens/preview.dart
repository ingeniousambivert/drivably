import 'dart:io';

import 'package:drivably_app/Module/const.dart';
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  TextField(
                    decoration: textFieldStyle("Driver's Name"),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: textFieldStyle("Driver's Age"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('here now');
          print(widget.imgPath);
          // getBytes().then((bytes) {

          //   print(bytes.buffer.asUint8List());
          //   Share.file('Share via', widget.fileName,
          //       bytes.buffer.asUint8List(), 'image/path');
          // });
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
