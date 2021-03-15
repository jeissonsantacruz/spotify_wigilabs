// Flutter dependencias
import 'package:flutter/material.dart';
// Plugins
import 'package:fluttertoast/fluttertoast.dart';

/*
  Esta funcion despliega un toast con alertas
*/
void showToast(String message, Color color,) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0
  );
}