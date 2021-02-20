import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/constants/consts.dart';
import 'package:drivably_app/screens/auth/carSignup.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({Key key}) : super(key: key);

  @override
  _UserSignupScreenState createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  APIServices _services = APIServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register to",
                            style: signUpTextStyle(),
                          ),
                          Text(
                            "Drivably",
                            style: signUpTextStyle(),
                          ),
                          SizedBox(height: 50),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                signUpName = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: textFormFieldStyle("Enter your name"),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                signUpEmail = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: textFormFieldStyle("Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                signUpPhoneNumber = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            decoration:
                                textFormFieldStyle("Enter your phone number"),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                signUpPassword = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                            decoration: textFormFieldStyle("Enter a password"),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                signUpConfirmPassword = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              return null;
                            },
                            decoration:
                                textFormFieldStyle("Confirm your password"),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // if (confirmPassword == password) {
                          //   print("Pass : " +
                          //       name +
                          //       email +
                          //       password +
                          //       phoneNumber);

                          //   await _services.postSignUpUser(
                          //       name, email, password, phoneNumber);
                          //   pushToNext(
                          //     context,
                          //     RegScreen(),
                          //   );
                          // }
                          pushToNext(
                            context,
                            CarSignupScreen(),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 21.0,
                        ),
                        child: Text(
                          "Next",
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
        ),
      ),
    );
  }
}
