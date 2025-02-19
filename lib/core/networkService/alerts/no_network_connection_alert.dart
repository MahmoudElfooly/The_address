import 'package:flutter/material.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("No Internet Connection"),
        content: Text("Please check your network and try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
