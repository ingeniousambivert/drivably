import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/screens/auth/carSignup.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:drivably_app/utils/constants/consts.dart';
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
  bool _obscureText = true;
  IconData _icon = Icons.lock;

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
                          SizedBox(
                            height: 60.0,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  signUpPassword = value;
                                });
                              },
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF212121),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color(0xff707070), width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Color(0xff707070), width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffix: IconButton(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Icon(
                                      _icon,
                                      color: Colors.white,
                                      size: 23.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_obscureText == true) {
                                      setState(() {
                                        _obscureText = false;
                                        _icon = Icons.lock_open;
                                      });
                                    } else {
                                      setState(() {
                                        _obscureText = true;
                                        _icon = Icons.lock;
                                      });
                                    }
                                  },
                                ),
                                labelText: "Enter your password",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Color(0xFFB3B1B1)),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await _services.signUpUser(signUpName, signUpEmail,
                              signUpPassword, signUpPhoneNumber);

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