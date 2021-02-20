import 'package:drivably_app/Constants/const.dart';
import 'package:drivably_app/Screen/CameraScreens/camera.dart';

import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String licensePlate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Register with License plate",
                style: signUpTextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter license plate number';
                    }
                    return null;
                  },
                  autofocus: true,
                  decoration: textFormFieldStyle("Ex. GJ 00 xx 0000"),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      licensePlate = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              cars.add(licensePlate);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            }
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_right_sharp,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
    );
  }
}
