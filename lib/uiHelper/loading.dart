import 'package:flutter/material.dart';

import '../main.dart';

showLoading({BuildContext? context, Color? loadingColor}) {
  showDialog<String>(
    barrierDismissible: false,
    context: context ?? navigatorKey.currentContext!,
    barrierColor: Colors.black38,
    builder: (BuildContext context) => PopScope(
      canPop: false,
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Center(
          child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: loadingColor ?? Colors.blue,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "loading Data",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )),
        ),
      ),
    ),
  );
}

hideLoading() => Navigator.pop(navigatorKey.currentContext!);
