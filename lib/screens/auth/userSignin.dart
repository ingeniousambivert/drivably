import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/constants/consts.dart';
import 'package:drivably_app/screens/dashboard/dashboard.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:flutter/material.dart';

class UserSigninScreen extends StatefulWidget {
  @override
  _UserSigninScreenState createState() => _UserSigninScreenState();
}

class _UserSigninScreenState extends State<UserSigninScreen> {
  APIServices _service = APIServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome back !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 60),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    signInEmail = value;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF212121),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Color(0xff707070), width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Color(0xff707070), width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    signInPassword = value;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF212121),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Color(0xff707070), width: 1),
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Color(0xff707070), width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
                ),
              ),
              Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account ? ",
                    style: TextStyle(
                        color: Color(0xff868691),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                    children: [
                      TextSpan(
                          text: "Register",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  await _service.signInUser(signInEmail, signInPassword);
                  pushToNext(context, DashboardScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 21.0,
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
