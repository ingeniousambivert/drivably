import 'package:drivably_app/screens/camera/camera.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:drivably_app/utils/constants/consts.dart';
import 'package:flutter/material.dart';

class CarSignupScreen extends StatefulWidget {
  @override
  _CarSignupScreenState createState() => _CarSignupScreenState();
}

class _CarSignupScreenState extends State<CarSignupScreen> {
  String licensePlate, name;
  final _formKey = GlobalKey<FormState>();
  APIServices services = APIServices();

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
                "Add your car's license plate number",
                style: signUpTextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a license plate number';
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: textFormFieldStyle("Ex. XX 00 xx 0000"),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          licensePlate = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a license plate number';
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: textFormFieldStyle("Enter car name"),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          name = value;
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var plateNumber =
                  licensePlate.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
              setState(() {
                setLicense = licensePlate;
              });

              dynamic result = await services.addCarData(plateNumber, name);
              if (result != "PASS") {
                //TODO: Add tost
                //message: result
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              }
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
