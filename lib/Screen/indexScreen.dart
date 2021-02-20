import 'package:drivably_app/Config/routing.dart';
import 'package:drivably_app/Constants/const.dart';
import 'package:drivably_app/Screen/loginScreen.dart';
import 'package:drivably_app/Screen/secSignUpScreen.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/background.png"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                child: Column(
                  children: [
                    Text(
                      "Drivably",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Car Safety Assistant Smart cars are not a new concept. This is a quick sign in / register screen of a current project.",
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: darkGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            onPressed: () {
                              pushToNext(
                                context,
                                SignupSecScreen(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 21.0, horizontal: 35.0),
                              child: Text("Register"),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              pushToNext(
                                context,
                                LoginScreen(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 21.0, horizontal: 35.0),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
