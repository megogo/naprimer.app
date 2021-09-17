import 'package:flutter/material.dart';

class AppColors {
  static const lightGrey = Color.fromRGBO(180, 180, 180, 0.5);
  static const accentBlue = Color.fromRGBO(43, 103, 246, 1.0);
  static const white = Colors.white;
  static const black = Colors.black;
  static const red = Color.fromRGBO(255, 64, 64, 1);
  static const videoBackground = Color.fromRGBO(32, 32, 32, 1);
  static const darkButton = Color.fromRGBO(25, 25, 25, 1);
  static const greyTextDark = Color.fromRGBO(140, 140, 140, 1);
  static const greyText = Color.fromRGBO(223, 223, 223, 1);
  static const darkGrey = Color.fromRGBO(59, 59, 59, 1);
  static const greenSuccess = Color.fromRGBO(39, 174, 96, 1);
  static const backgroundDefaultProfileColor = Color(0xffD030C6);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

