import 'dart:convert';
import 'package:cargogomapp/models/user_auth_api_response.dart';
import 'package:cargogomapp/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user_core_data.dart';

class UserApi {
  static Future<bool> accessTokenCall() async {
    UserCoreData? savedUser = await UserCoreData.getUser();
    if (savedUser == null) {
      return false;
    }

    String accessToken = savedUser.accessToken;
    String apiUrl =
        '${AppConstants.baseUrl}${AppApiEndPoints.accessToken}/$accessToken';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonResponse = json.decode(response.body);
      final userApiResponse = UserAuthApiResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return userApiResponse.ok;
      } else {
        if (kDebugMode) {
          print('API Call Failed: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception during API call: $e');
      }
      return false;
    }
  }

  static Future<bool> register(
      String firstName, String lastName, String email, String password) async {
    String apiUrl = '${AppConstants.baseUrl}${AppApiEndPoints.register}';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      final jsonResponse = json.decode(response.body);
      final userApiResponse = UserAuthApiResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Register API Call Successful\n');
          print(userApiResponse.data["user"]);
        }
        UserCoreData.saveUser(
            UserCoreData.fromJson(userApiResponse.data["user"]));
        return userApiResponse.ok;
      } else {
        if (kDebugMode) {
          print('API Call Failed: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception during API call: $e');
      }
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    String apiUrl = '${AppConstants.baseUrl}${AppApiEndPoints.login}';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final jsonResponse = json.decode(response.body);
      final userApiResponse = UserAuthApiResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Login API Call Successful\n');
          print(userApiResponse.data["user"]);
        }
        UserCoreData.saveUser(
            UserCoreData.fromJson(userApiResponse.data["user"]));
        return userApiResponse.ok;
      } else {
        if (kDebugMode) {
          print('API Call Failed: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception during API call: $e');
      }
      return false;
    }
  }
}
