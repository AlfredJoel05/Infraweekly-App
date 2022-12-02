import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/services/request_file.dart';
import 'package:trid_travel/Utils/alert_dialog.dart';
import 'package:trid_travel/Utils/please_wait.dart';

import 'reset_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLogging = false;
  bool _isPressed = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // text controllers
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  // Function Sign in

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future forgotPassword(email, mobile) async {
    var data = jsonEncode(<String, String>{
      'email': email,
      'mobile': mobile,
    });

    var res = await check(data);
    var response = json.decode(res.body);
    setState(() {
      _isLogging = !_isLogging;
      _isPressed = !_isPressed;
    });
    if (response['status'] == 200) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPassword(),
            maintainState: true,
          ),
          (route) => false);
    } else {
      if (!mounted) return;
      showAlertDialogBox(
          context, 'Invalid Details\nor\nUser not found!', false);
    }
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
                  "Forgot Password",
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
                      hintText: 'Enter your registered email',
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

                // Mobile
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'Enter your registered mobile',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      labelText: "Mobile",
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

                // Description
                Text(
                  'If your email account is registered, You will be routed to a Reset Password page or you will be routed to Sign Up page',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
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
                            if (_formKey.currentState!.validate()) {
                              forgotPassword(_emailController.text,
                                  _mobileController.text);
                              setState(() {
                                _isLogging = !_isLogging;
                                _isPressed = !_isPressed;
                              });
                            }
                          },
                    child: _isLogging
                        ? const PleaseWait()
                        : Text(
                            "SUBMIT",
                            textAlign: TextAlign.center,
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
    );
  }
}
