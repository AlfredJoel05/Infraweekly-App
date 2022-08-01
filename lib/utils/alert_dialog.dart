import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlertDialogBox(BuildContext context, title, bstatus) {
  final alert = AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      content: bstatus
          ? const Icon(
              Icons.task_alt,
              color: Colors.green,
              size: 70,
            )
          : const Icon(
              Icons.dangerous,
              color: Color.fromARGB(255, 255, 68, 10),
              size: 70,
            ));

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
