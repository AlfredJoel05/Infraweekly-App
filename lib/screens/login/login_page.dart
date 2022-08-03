import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trid_travel/Utils/please_wait.dart';
import 'package:trid_travel/constants/constants_values.dart';
import 'package:trid_travel/screens/inapp/in_app_page.dart';
// import 'package:trid_travel/screens/inapp/updates_page.dart';
import 'package:trid_travel/services/request_file.dart';
import 'package:trid_travel/Utils/alert_dialog.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
// import 'package:trid_travel/Utils/alert_dialog.dart';

import 'forgot_password.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = true;
  bool _isLogging = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Function Sign in
  Future signIn(email, password) async {
    var data = jsonEncode(<String, String>{
      'email': email, 
      'password': password,
    });

    var res = await logIn(data);
    var response = json.decode(res.body);

    setState(() {
      _isLogging = !_isLogging;
    });

    if (response['status'] == 200) {
      setIsLoggedIn(true);
      if (!mounted) return;
      showAlertDialogBox(context, 'Login Successful', true);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();

        _emailController.clear();
        _passwordController.clear();

        Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute(
              builder: (context) => const InAppPage(),
              maintainState: true,
            ),
            (route) => false);
      });
    } else {
      if (!mounted) return;
      showAlertDialogBox(context, 'Incorrect\nEmail or Password', false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      "Sign in",
                      style: GoogleFonts.poppins(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 25),

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
                    const SizedBox(height: 25),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isSelected,
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: 'Max:8 chars, symbols and numbers',
                          border: const OutlineInputBorder(
                            borderRadius:  BorderRadius.all(Radius.circular(50)),
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
                                : const Icon(Icons.visibility, color: Colors.grey),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),

                    // Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              );
                            },
                            style:
                                TextButton.styleFrom(primary: Colors.black54),
                            child: const Text(
                              'ForgotPassword?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Login Button
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.amber),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signIn(_emailController.text,
                                _passwordController.text);
                            setState(() {
                              _isLogging = !_isLogging;
                            });
                          }
                        },
                        child: _isLogging
                            ? const PleaseWait()
                            : Text(
                                "LOGIN",
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Don't have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(primary: Colors.amber),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
