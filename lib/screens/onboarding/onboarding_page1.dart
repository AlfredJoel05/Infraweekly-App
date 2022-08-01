import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardPage1 extends StatelessWidget {
  const OnBoardPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
        child: Image.asset(
          'images/ob2.jpg',
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
          )
        ),
        Container(
          alignment: const Alignment(0, -0.87),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('Infrastructure Weekly',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
            ),
          ),
      ], 
    );
  }
}
