// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
    UserDetailsModel({
      required this.firstName,
      required this.lastName,
      required this.emailId,
      required this.mobile,
    });

    String firstName;
    String lastName;
    String emailId;
    String mobile;

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailId: json["emailId"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "emailId": emailId,
        "mobile": mobile,
    };
}
