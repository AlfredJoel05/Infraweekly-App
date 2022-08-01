// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/please_wait.dart';
import 'package:trid_travel/screens/login/login_page.dart';
import 'package:trid_travel/services/request_file.dart';
import 'package:trid_travel/Utils/alert_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isSelected = true;
  bool _isLogging = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();

  // Function Sign in
  Future sendSignUp(firstName, lastName, mobile, email, password) async {
    print(
        "First Name: $firstName | Last Name: $lastName | Mobile: $mobile | Email: $email | Password: $password");
    var data = jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'emailId': email,
      'password': password,
    });

    var res = await signUp(data);
    var response = json.decode(res.body);
    print(
        'Response: ${response['body']} | Status Code = ${response['status']}');
    setState(() {
      _isLogging = !_isLogging;
    });
    if (res.statusCode == 201) {
      if (!mounted) return;
      showAlertDialogBox(context, 'User Created Successfully \n Please Login', true);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      });

      // Status Code change requested for Already Exsiting User from 400 to 401
    } else if (res.statusCode == 400) {
      String errorStatement = '';
      response['body'].forEach((key, value) {
        errorStatement = '$errorStatement$value\n\n';
      });
      if (!mounted) return;
      showAlertDialogBox(context, errorStatement, false);
    }
    // Will execute when user already exists - Status Code: 401
    else {
      String errorStatement = '${response['body'].toString()}\n\nPlease Login';
      if (!mounted) return;
      showAlertDialogBox(context, errorStatement, false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // First Name
                  TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        prefixIcon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.amber)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Last Name
                  TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        prefixIcon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.amber)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Mobile
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Mobile",
                        hintText: 'Maximum of 10 digits',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        prefixIcon: Icon(Icons.call),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.amber)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: 'Eg: email@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.amber)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isSelected,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: 'Max:10 chars, symbols and numbers',
                        hintStyle: const TextStyle(
                          fontSize: 11,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSelected = !_isSelected;
                            });
                          },
                          child: _isSelected
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility,
                                  color: Colors.grey),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  // Login Button
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.amber),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLogging = !_isLogging;
                          });
                          sendSignUp(
                            _firstNameController.text,
                            _lastNameController.text,
                            _mobileController.text,
                            _emailController.text,
                            _passwordController.text
                          );
                        }
                      },
                      child: _isLogging
                          ? const PleaseWait()
                          : Text(
                              "SIGN IN",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
