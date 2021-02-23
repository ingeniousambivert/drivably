import 'package:flutter/material.dart';
import 'package:key_app/services/clint.dart';
import 'package:key_app/utils/const.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final _formKey = GlobalKey<FormState>();
  ApiServices _service = ApiServices();
  bool _obscureText = true;
  IconData _icon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: ListView(
            children: [
              Image.asset("assets/background.png"),
              SizedBox(height: 40),
              Text(
                "Drivably",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 45,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "SignIn in application and get car access",
                style: TextStyle(
                  color: grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            signInEmail = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
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
                          labelText: "Email",
                          labelStyle:
                              TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60.0,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              signInPassword = value;
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
                            labelText: "Password",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFB3B1B1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.white,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(signInEmail + signInPassword);
                            await _service.signInUser(
                                signInEmail, signInPassword);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
