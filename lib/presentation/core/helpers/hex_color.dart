// src: https://stackoverflow.com/a/50081214
import 'package:flutter/material.dart';

Color convertHex(String hexString, {bool ignoreEmpty = false}) {
  if (hexString == null) return null;
  if (hexString.isEmpty) {
    if (ignoreEmpty)
      return null;
    else
      throw ArgumentError.value(hexString, 'hexString');
  }
  try {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  } catch (e) {
    throw ArgumentError.value(hexString, 'hexString');
  }
}

extension ColorGetter on Color {
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
