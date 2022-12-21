import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/screens/inapp/in_app_page.dart';
import '../login/login_page.dart';

class OnboardPage2 extends StatelessWidget {
  const OnboardPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/ob3.jpg',
            fit: BoxFit.fill,
          ),
        ),
        // ignore: sized_box_for_whitespace
        Container(
          alignment: const Alignment(0, 5),
          child: Image.asset(
            'images/ob4.png',
          ),
        ),
        // ignore: sized_box_for_whitespace
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: Image.asset('images/logow.png'),
                ),
                Flexible(
                  child: Text(
                    'National Center for Transportation Infrastructure Durability & Life Extension',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: (() {
                  showModalBottomSheet(
                      // routeSettings: ,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.35),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      context: context,
                      builder: (context) => Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Text(
                                    'For News and Alerts',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Text(
                                    'Signup using your email for latest news and alerts on research',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Skip button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const InAppPage())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(170, 55),
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              Colors.grey.shade700),
                                      child: Text(
                                        "Skip",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),

                                    // Signup button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(170, 55),
                                          backgroundColor: Colors.amber),
                                      child: Text(
                                        "SIGN IN",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                }),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade600),
                child: Text(
                  "Let's Go",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
