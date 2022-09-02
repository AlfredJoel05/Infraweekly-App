import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trid_travel/constants/constants_values.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Sign Up - User Creation
Future<http.Response> signUp(data) async {
  final response = await http.post(
    Uri.parse('https://infraweekly.herokuapp.com/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  );
  return response;
}

// Get User Details
Future<http.Response> getUserDetails() async {
  final response = await http.get(
    Uri.parse('https://infraweekly.herokuapp.com/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}

// Reset Password - Change Password
Future<http.Response> resetPassword(data) async {
  final response = await http.put(
    Uri.parse('https://infraweekly.herokuapp.com/reset'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  );
  return response;
}

// Login
Future<http.Response> logIn(data) async {
  final response = await http.post(
    Uri.parse('https://infraweekly.herokuapp.com/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data
  );
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    createJwt(res['body']);
  }
  return response;
}

// Check User is Present in DB
Future<http.Response> check(data) async {
  final response = await http.post(
    Uri.parse('https://infraweekly.herokuapp.com/check'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': getJwt().toString(),
    },
    body: data,
  );
  return response;
}

// Current Week Updates
// Future<CurrentWeekUpdateModel> getCurrentWeekUpdates() async {
//   final response = await http.get(
//     Uri.parse('https://infraweekly.herokuapp.com/currentweekupdates'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': jwtToken
//     },
//   ).timeout(const Duration(seconds: 20), onTimeout: () {
//     return http.Response('Connection Time Out', 408);
//   });
//   if (response.statusCode == 200) {
//     final currentWeekData = currentWeekUpdateModelFromJson(response.body);
//     return currentWeekData;
//   } else {
//     final currentWeekData = currentWeekUpdateModelFromJson(response.body);
//   }
//   final currentWeekUpdateData = currentWeekUpdateModelFromJson(response.body);
//   return currentWeekUpdateData;
// }

// Shared Preferences