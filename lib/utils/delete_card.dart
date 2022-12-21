import 'package:flutter/material.dart';

Future showDeletePopup(context) async {
  bool result = false;
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Info'),
          content:
              const Text('Are you sure you want to delete this informtaion?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700),
              child: const Text(
                'No',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              },
              child: const Text('Yes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ) ??
      result; //if showDialouge had returned null, then return false
}
