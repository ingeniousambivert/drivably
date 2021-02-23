import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drivably_app/utils/classes/user.dart';
import 'package:drivably_app/utils/constants/consts.dart';
import 'package:drivably_app/utils/storage/localStorage.dart';

// ignore: todo
/* TODO
POST - car/ (with safe_user object) 
PUT - user/ (with car licennse plate number)
PUT - user/ (with facial data)

POST driver/signup - Owner adds driver profiles
POST driver/signin - Signin for the key app


FLOW CHANGE :
  User Signup page (store user object in state) -> Car Signup page (embed safe_user object in
  car object and make a POST Request to car/ first and when successful make a POST Request 
  to user/ with the car license plate number added) -> Facial Data page (make a PUT request 
  to user/ to upload the facial data) -> Dashboard

  Look at car, user model for reference
*/

class APIServices {
  Dio dio = new Dio();

  Future signInUser(email, password) async {
    try {
      Response response = await dio.post(
        "$baseUrl/owner/signin",
        data: {
          "username": email,
          "password": password,
        },
      );
      setTokenAndId(response.data['access_token'], response.data['id']);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future signUpUser(name, email, password, phone) async {
    try {
      Response response = await dio.post(
        "$baseUrl/owner/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );
      print("response");
      setTokenAndId(response.data['access_token'], response.data['id']);

      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future postCarData(licenseNumber, name) async {
    String _token;
    await getToken().then((value) {
      _token = value;
    });
    print(_token);
    try {
      Response response = await dio.post(
        "$baseUrl/car",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
        data: {
          "car_license": "$licenseNumber",
          "car_name": "$name",
          "owner_mail": "$signUpEmail"
        },
      );
      print("response");
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future setDriver(String file) async {
    String _id, _token;
    await getId().then((value) {
      _id = value;
    });
    await getToken().then((value) {
      _token = value;
    });

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file),
    });

    Response response = await dio.put(
      "$baseUrl/user/face/$_id",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
      data: formData,
    );
    print(response);
  }

  Future getUserData() async {
    String _id, _token;
    await getId().then((value) {
      _id = value;
    });
    await getToken().then((value) {
      _token = value;
    });
    try {
      Response response = await dio.get("$baseUrl/user/$_id",
          options: Options(
            headers: {
              'Authorization': 'Bearer $_token',
            },
          ));

      UserData.fromJson(jsonDecode(response.data));
    } catch (e) {
      print(e);
    }
  }
}
