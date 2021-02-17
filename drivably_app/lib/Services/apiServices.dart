import 'package:dio/dio.dart';
import 'package:drivably_app/Module/const.dart';
import 'package:drivably_app/Services/localStorage.dart';

class ApiServices {
  Dio dio = new Dio();

  Future postSignIdUser() async {
    print(setUserName + setSignInPassword);
    try {
      Response response = await dio.post(
        "http://192.168.16.138:8008/signin",
        data: {
          "username": "$setUserName",
          "password": "$setSignInPassword",
        },
      );
      setToken(response.data['access_token']);
    } catch (e) {
      print(e);
    }
  }

  postSignUpUser() async {
    try {
      Response response =
          await dio.post("http://192.168.16.138:8008/signup", data: {
        "name": "$setName",
        "email": "$setEmail",
        "password": "$setPassword",
        "facial_data": "./faces/JohnDoe_Face.jpg",
        "cars": ["car-id-1", "car-id-2"],
        "phone": "$setPhone"
      });

      setToken(response.data['access_token']);
    } catch (e) {
      print(e);
    }
  }
}
