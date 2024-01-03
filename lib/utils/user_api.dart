import 'dart:convert';
import 'package:cargogomapp/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class UserApi {

  static void register(String firstName, String lastName, String email, String password) async {

    String apiUrl = '${AppConstants.baseUrl}/auth/register';

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

      if (response.statusCode == 200) {
        print('API Call Successful\n');
        print(response.body);
      } else {
        // Handle API error
        print('API Call Failed: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during API call: $e');
    }
  }

  static void login(String email, String password) async {

    String apiUrl = '${AppConstants.baseUrl}/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('API Call Successful\n');
        print(response.body);
      } else {
        // Handle API error
        print('API Call Failed: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during API call: $e');
    }
  }
}