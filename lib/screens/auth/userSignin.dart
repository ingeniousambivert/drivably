import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/screens/dashboard/dashboard.dart';
import 'package:drivably_app/services/api/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSigninScreen extends StatefulWidget {
  @override
  _UserSigninScreenState createState() => _UserSigninScreenState();
}

class _UserSigninScreenState extends State<UserSigninScreen> {
  APIServices _service = APIServices();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  IconData _icon = Icons.lock;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Form(
            key: _formKey,
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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
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
                    labelStyle:
                        TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 60.0,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        password = value;
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
                        borderSide:
                            new BorderSide(color: Color(0xff707070), width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Color(0xff707070), width: 1),
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
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xFFB3B1B1)),
                    ),
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
                    print(email + password);
                    if (_formKey.currentState.validate()) {
                      dynamic result =
                          await _service.signInUser(email, password);
                      print(result);
                      if (result != "PASS") {
                        Get.snackbar("Error", "$result",
                            backgroundColor: Colors.white,
                            colorText: Colors.black);
                      } else {
                        removeUntil(context, DashboardScreen());
                      }
                    }
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
      ),
    );
  }
}
