import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drivably_app/utils/classes/driver.dart';
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
          "username": "$email",
          "password": "$password",
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

  Future signUpDriver(name, email, password, phone) async {
    try {
      Response response = await dio.post(
        "$baseUrl/driver/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );
      print("response");

      print(response);

      // String _token, _license;

      // await getCarNumber().then((value) {
      //   _license = value;
      // });
      // await getToken().then((value) {
      //   _token = value;
      // });

      // Response res = await dio.put(
      //   "$baseUrl/car/driver/$_license",
      //   options: Options(
      //     headers: {
      //       'Authorization': 'Bearer $_token',
      //     },
      //   ),
      //   data: email,
      // );
      // print(res);
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

  Future<List<DriverDataSec>> getDrivers() async {
    String _token;
    await getToken().then((value) {
      _token = value;
    });

    try {
      Response response = await dio.get(
        "$baseUrl/car",
        options: Options(headers: {
          'Authorization': 'Bearer $_token',
        }),
      );
      return (response.data['data'] as List)
          .map((p) => DriverDataSec.fromJson(p))
          .toList();
    } catch (e) {
      return (e);
    }
  }

  Future printDrivers(doc) async {
    String _token;
    await getToken().then((value) {
      _token = value;
    });

    try {
      Response response = await dio.get(
        "$baseUrl/user/$doc",
        options: Options(headers: {
          'Authorization': 'Bearer $_token',
        }),
      );
      print(response.data['data']);
    } catch (e) {
      print(e);
    }
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

  Future addCarData(plate, name) async {
    String _token;
    await getToken().then((value) {
      _token = value;
    });
    try {
      Response response = await dio.post("$baseUrl/car/",
          options: Options(
            headers: {
              'Authorization': 'Bearer $_token',
            },
          ),
          data: {
            "car_license": "$plate",
            "car_name": "$name",
            "owner_email": "$signUpEmail",
            "drivers_email": ["$signUpEmail"],
            "current_location": {},
            "alcohol_concentrations": [{}],
            "casualties": [],
            "activities": []
          });
      setCarNumber(plate);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
