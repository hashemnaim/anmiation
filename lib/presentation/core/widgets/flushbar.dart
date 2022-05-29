import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Size getWidgetSize(GlobalKey key) {
  final RenderBox renderBox = key.currentContext?.findRenderObject();
  return renderBox?.size;
}

void showToast(String message) {
  Fluttertoast.showToast(msg: message);
}

Flushbar showSuccessBar(BuildContext context, String message,
    {String title = 'Aktion erfolgreich.'}) {
  return Flushbar(
    title: title,
    message: message,
    icon: const Icon(
      Icons.check,
      size: 28.0,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 4),
    backgroundGradient: LinearGradient(
      colors: [Colors.green[600], Colors.green[400]],
    ),
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}

Flushbar showErrorBar(BuildContext context, String message,
    {String title = 'Fehler aufgetreten.'}) {
  return Flushbar(
    title: title,
    message: message,
    icon: const Icon(
      Icons.error,
      size: 28.0,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 4),
    backgroundGradient: LinearGradient(
      colors: [Colors.red[600], Colors.red[400]],
    ),
    onTap: (flushbar) => flushbar.dismiss(),
  )..show(context);
}
