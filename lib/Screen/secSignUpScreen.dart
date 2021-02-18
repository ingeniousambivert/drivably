import 'package:drivably_app/Module/const.dart';
import 'package:drivably_app/Module/routing.dart';
import 'package:drivably_app/Screen/CameraScreens/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupSecScreen extends StatefulWidget {
  const SignupSecScreen({Key key}) : super(key: key);

  @override
  _SignupSecScreenState createState() => _SignupSecScreenState();
}

class _SignupSecScreenState extends State<SignupSecScreen> {
  String name, email, phoneNumber, password, cnfPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: SafeArea(
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
                          "Let's register",
                          style: signUpTextStyle(),
                        ),
                        Text(
                          "your self !",
                          style: signUpTextStyle(),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter User Name';
                            }
                            return null;
                          },
                          decoration:
                              textFormFieldStyle("Enter your full name"),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          decoration: textFormFieldStyle("Enter email"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Phone Number';
                            }
                            return null;
                          },
                          decoration: textFormFieldStyle("Enter Phone Number"),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          decoration: textFormFieldStyle("Enter Password"),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              cnfPassword = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Confirm Password';
                            }
                            return null;
                          },
                          decoration: textFormFieldStyle("Confirm password"),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          setName = name;
                          setEmail = email;
                          setPassword = password;
                          setPhone = phoneNumber;
                        });
                        pushToNext(
                          context,
                          CameraScreen(),
                        );
                      }

                      // if (cnfPassword == password) {
                      //   print("Pass");
                      //   _services.postSignUpUser();
                      //   pushToNext(
                      //     context,
                      //     CameraScreen(),
                      //   );
                      // }
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
      ),
    );
  }
}
