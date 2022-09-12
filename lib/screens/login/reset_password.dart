import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/services/request_file.dart';
import 'package:trid_travel/Utils/alert_dialog.dart';
import 'package:trid_travel/utils/please_wait.dart';

import 'login_page.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLogging = false;
  bool _isPressed = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confrimPassowrdController = TextEditingController();
  // Function Sign in

  Future forgotPassword(email, password, confirmPassword) async {
    var data = jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    var res = await resetPassword(data);
    var response = json.decode(res.body);

    if (response['status'] == 200) {
      if (!mounted) return;
      setState(() {
        _isLogging = !_isLogging;
        _isPressed = !_isPressed;
      });
      showAlertDialogBox(context, 'Password Reset\nSuccessful', true);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
      });
    } else {
      if (!mounted) return;
      showAlertDialogBox(context, 'Invalid Details', false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confrimPassowrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Reset Password",
                  style: GoogleFonts.poppins(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      height: 1),
                ),
                const SizedBox(height: 45),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'Re-Enter your registered email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Email",
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
                const SizedBox(height: 15),

                // Passowrd
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: '5-15 Characters',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
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
                const SizedBox(height: 35),

                // Confirm Password
                TextFormField(
                  controller: _confrimPassowrdController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      hintText: 'Re-Enter your password',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
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
                const SizedBox(height: 45),
                // Reset Button
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber),
                  child: MaterialButton(
                    onPressed: _isPressed
                        ? null
                        : () {
                            if (_formKey.currentState!.validate() &&
                                _confrimPassowrdController.text ==
                                    _passwordController.text) {
                              forgotPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                  _confrimPassowrdController.text);
                              setState(() {
                                _isLogging = !_isLogging;
                                _isPressed = !_isPressed;
                              });
                            } else {
                              showAlertDialogBox(
                                  context, 'Enter all details', false);
                            }
                          },
                    child: _isLogging
                        ? const PleaseWait()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RESET PASSWORD",
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 7),
                              const Icon(Icons.send, color: Colors.white)
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
