import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PleaseWait extends StatelessWidget {
  const PleaseWait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 4.0,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          "Please Wait...",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
