import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserCoreData {
  final String accessToken;
  final int id;
  final String email;
  final String firstName;
  final String lastName;

  UserCoreData({
    required this.accessToken,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  factory UserCoreData.fromJson(Map<String, dynamic> json) {
    return UserCoreData(
      accessToken: json['access_token'],
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  static Future<void> saveUser(UserCoreData user) async {
    const String userKey = 'user';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userJson = json.encode(user.toJson());
    prefs.setString(userKey, userJson);
  }

  static Future<UserCoreData?> getUser() async {
    const String userKey = 'user';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(userKey);


    if (userJson != null) {
      return UserCoreData.fromJson(json.decode(userJson));
    } else {
      return null;
    }
  }
}
