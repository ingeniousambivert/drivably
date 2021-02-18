import 'package:drivably_app/Module/const.dart';
import 'package:drivably_app/Module/routing.dart';
import 'package:drivably_app/Screen/CameraScreens/camera.dart';
import 'package:drivably_app/Services/apiServices.dart';
import 'package:flutter/material.dart';

class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String licensePlate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: TextField(
                autofocus: true,
                // onSubmitted: p,
                decoration: textFieldStyle("Ex. GJ 00 xx 0000"),
                textInputAction: TextInputAction.next,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: FloatingActionButton(
          onPressed: () {
            cars.add(licensePlate);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignupSecScreen(
                        licensePlate: licensePlate,
                      )),
            );
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

class SignupSecScreen extends StatefulWidget {
  final String licensePlate;
  const SignupSecScreen({Key key, @required this.licensePlate})
      : super(key: key);

  @override
  _SignupSecScreenState createState() => _SignupSecScreenState();
}

class _SignupSecScreenState extends State<SignupSecScreen> {
  String name, email, phoneNumber, password, cnfPassword;
  ApiServices _services = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's register",
                        style: signUpTextStyle(),
                      ),
                      Text(
                        "your self !",
                        style: signUpTextStyle(),
                      ),
                      SizedBox(height: 50),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: textFieldStyle("Enter your full name"),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: textFieldStyle("Enter email"),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        decoration: textFieldStyle("Enter Phone Number"),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: textFieldStyle("Enter Password"),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            cnfPassword = value;
                          });
                        },
                        decoration: textFieldStyle("Confirm password"),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      setName = name;
                      setEmail = email;
                      setPassword = password;
                      setPhone = phoneNumber;
                    });
                    if (cnfPassword == password) {
                      print("Pass");
                      _services.postSignUpUser();
                      pushToNext(
                        context,
                        CameraScreen(),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 21.0,
                    ),
                    child: Text(
                      "Next to add Driver's Details",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  color: Colors.white,
                  minWidth: MediaQuery.of(context).size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
