import 'package:drivably_app/routes/routing.dart';
import 'package:drivably_app/utils/constants/consts.dart';
import 'package:drivably_app/screens/auth/userSignin.dart';
import 'package:drivably_app/screens/auth/userSignup.dart';
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
                        fontSize: 45,
                      ),
                    ),
                    SizedBox(
                      height: 65,
                    ),
                    Text(
                      "Car safety and assistance system with Internet Of Things",
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
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
                                UserSignupScreen(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 21.0, horizontal: 35.0),
                              child: Text("Sign Up"),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              pushToNext(
                                context,
                                UserSigninScreen(),
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
