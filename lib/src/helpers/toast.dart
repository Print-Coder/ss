
import 'package:flutter/material.dart';

Widget Toastmsg(BuildContext context, String msg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[300],
    ),
    child:
        // Icon(Icons.check),
        // SizedBox(
        //   width: 12.0,
        // ),
        Text(msg),
  );
}
