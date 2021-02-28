import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drivably_app/utils/classes/user.dart';
import 'package:drivably_app/utils/constants/consts.dart';
import 'package:drivably_app/utils/storage/localStorage.dart';

import '../../utils/constants/consts.dart';

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
    print(email);
    try {
      Response response = await dio.post(
        "$baseUrl/owner/signin",
        data: {
          "username": "$email",
          "password": "$password",
        },
      );
      if (response.data['access_token'] == null) {
        return (response.data['message']);
      } else {
        setTokenAndId(response.data['access_token']);
        return "PASS";
      }
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
      if (response.data['access_token'] == null) {
        return (response.data['message']);
      } else {
        setTokenAndId(response.data['access_token']);
        return "PASS";
      }
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

      // setDriveInCarObject(email);

      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future setDriveInCarObject(email) async {
    String licenseNumber = "gl 33 bl 9898", _token;
    await getToken().then((value) {
      _token = value;
    });

    Response response = await dio.put(
      "$baseUrl/car/driver/$licenseNumber",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
      data: email,
    );

    print(response);
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

  // // ignore: missing_return
  // Future<List<DriverDataSec>> getDrivers() async {
  //   String _token;
  //   await getToken().then((value) {
  //     _token = value;
  //   });

  //   try {
  //     Response response = await dio.get(
  //       "$baseUrl/car",
  //       options: Options(headers: {
  //         'Authorization': 'Bearer $_token',
  //       }),
  //     );
  //     (response.data['data'] as List)
  //         .map((p) => DriverDataSec.fromJson(p))
  //         .toList();
  //   } catch (e) {
  //     return (e);
  //   }
  // }

  // Future<List<DriverDataSec>> printDrivers(doc) async {
  //   String _token;
  //   await getToken().then((value) {
  //     _token = value;
  //   });

  //   try {
  //     Response response = await dio.get(
  //       "$baseUrl/user/$doc",
  //       options: Options(headers: {
  //         'Authorization': 'Bearer $_token',
  //       }),
  //     );
  //     return (response.data['data'] as List)
  //         .map((p) => DriverDataSec.fromJsonData(p))
  //         .toList();
  //   } catch (e) {
  //     return (e);
  //   }
  // }

  Future getDrivers() async {
    String _token;
    await getToken().then((value) {
      _token = value;
    });

    try {
      Response response = await dio.get(
        "$baseUrl/car",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
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
            "alcohol_concentrations": [],
            "casualties": [],
            "activities": []
          });

      if (response.data['data'] == null) {
        return response.data['message'];
      } else {
        print(response);
        print(response.data['data']['car_license']);
        setCarNumber(response.data['data']['car_license']);
        return "PASS";
      }
    } catch (e) {
      print(e);
    }
  }
}
