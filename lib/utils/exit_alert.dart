import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<bool> showExitPopup(context) async {
  return await showDialog( 
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout & Exit'),
      content: const Text('Are you sure you want to Logout?'),
      actions:[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child:const Text('No', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        ElevatedButton(
          onPressed: () => SystemNavigator.pop(), 
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade700
          ),
          child:const Text('Yes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  )??false; //if showDialouge had returned null, then return false
}