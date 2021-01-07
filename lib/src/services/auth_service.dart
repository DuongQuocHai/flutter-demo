import 'dart:convert';

import 'package:flutter_app/src/models/api_response.dart';
import 'package:flutter_app/src/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const API = 'http://footcer-shop.herokuapp.com';

  Future<APIResponse<bool>> loginService(String phone, String password) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(API + '/users/login',
          body: {"phone": phone, "password": password});
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body["status"] == 200) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      } else {
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      }
    } catch (err) {
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }
  }
}
