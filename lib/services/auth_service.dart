import 'dart:convert';
import 'dart:io';

import "package:http/http.dart " as http;
import 'package:researchapp/env.dart';
import 'package:researchapp/services/exceptions.dart';

class AuthService {
  Future<dynamic> login(String phonenumber, String OTP) async {
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(SERVER_URL + "/Validate-Login"),
          headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
          body: jsonEncode({"MobileNum": phonenumber, "OTP": OTP}));
      responseJson = _returnresponse_login(response);
    } on SocketException {
      throw InternetError("No internet Connection");
    }
    return responseJson;
  }

  Future<dynamic> signup(
      String phoneno, String OTP, String name, int age, String gender) async {
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(SERVER_URL + "/Validate-signup"),
          headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
          body: jsonEncode({
            "MobileNum": phoneno,
            "OTP": OTP,
            "FirstName": name,
            "age": age,
            "addr": "sus",
            "gender": gender
          }));
      print(response.body);
      responseJson = _returnresponse_signup(response);
      return responseJson;
    } on SocketException {
      throw InternetError("No internet Connection");
    }
  }

  _returnresponse_login(http.Response response) {
    switch (response.statusCode) {
      case 201:
        throw PasswordError(response.body);
      case 511:
        throw APIKeyError(response.body);
      case 401:
        {
          //api doesn't have username and password as parameters
          //user not found
          Map<String, dynamic> responseJson =
              jsonDecode(response.body.toString());
          print(responseJson.keys);
          if (!responseJson["user_exits"])
            throw UserNotFoundError("user not found");
          else
            throw APIKeyError("apirerror");
        }
      case 200:
        {
          //sucess
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }
    }
  }

  _returnresponse_signup(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }
      case 401:
        {
          //email already exists
          //

          throw APIKeyError("random error");
        }
    }
  }
}
