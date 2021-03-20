import 'package:dio/dio.dart';
import 'package:drivably_app/utils/classes/car.dart';
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
    print(email + password);
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

      setDriveInCarObject(email);

      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<List<CarData>> getCarData() async {
    String _token, _email;
    await getToken().then((value) {
      _token = value;
    });
    await getEmail().then((value) {
      _email = value;
    });

    Response response = await dio.get(
      "$baseUrl/user/car/?email=zinzuvadiyameet98%40gmail.com",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    // print(response.data['data'][0]);

    return (response.data['data'] as List)
        .map((p) => CarData.fromJson(p))
        .toList();
  }

  Future setDriveInCarObject(email) async {
    String licenseNumber = "GJ33BL9898", _token;
    await getToken().then((value) {
      _token = value;
    });

    Response response = await dio.put(
      "$baseUrl/car/driver/{license}?license_number=$licenseNumber&car_driver=$email",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );

    print(response);
  }

  Future setDriver(String file) async {
    String _email, _token;
    await getEmail().then((value) {
      _email = value;
    });
    await getToken().then((value) {
      _token = value;
    });

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file),
    });

    Response response = await dio.put(
      "$baseUrl/user/face/$_email",
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
      data: formData,
    );
    print(response);
  }

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

      for (var doc in response.data['data'][0]['drivers_email']) {
        tempDriverEmail.add(doc);
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<String> getUserData() async {
    tempDriverEmail = [];
    await getDrivers();
    print(tempDriverEmail);
    String _token;
    await getToken().then((value) {
      _token = value;
    });

    for (var doc in tempDriverEmail) {
      Response response = await dio.get(
        "$baseUrl/user/$doc",
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      print(response.data['data']);
    }
    // print(response.data['data']);
    // for (var doc in tempDriverEmail) {
    //   String _token;
    //   await getToken().then((value) {
    //     _token = value;
    //   });

    //   try {
    //     Response response = await dio.get(
    //       "$baseUrl/user/$doc",
    //       options: Options(
    //         headers: {
    //           'Authorization': 'Bearer $_token',
    //         },
    //       ),
    //     );
    //     // print(response.data['data']);
    //     return (response.data['data'] as List)
    //         .map((p) => UserData.fromJson(p))
    //         .toList();
    //   } catch (e) {
    //     print(e);
    //   }
    // }
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
