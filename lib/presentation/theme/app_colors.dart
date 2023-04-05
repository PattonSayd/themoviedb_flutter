import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const Color _kDarkBlue = Color.fromRGBO(3, 37, 65, 1);
  static const Color _kBlack = Colors.black;
  static const Color _kGrey = Colors.grey;
  static const Color _kLightPrimary = Color(0xFF01B4E4);
  static const Color _white = Colors.white;
  static const Color _kRed = Colors.red;
  static const Color _kBlack87 = Colors.black87;
  static const Color _kBlueShade400 = Color.fromARGB(255, 66, 165, 245);
  static const Color _kBlack12 = Colors.black12;

  static const Color theme = _kDarkBlue;
  static const Color description = _kBlack;
  static const Color superScript = _kGrey;
  static const Color button = _white;
  static const Color buttonLink = _kLightPrimary;
  static const Color errorText = _kRed;
  static const Color inputText = _kBlack87;
  static const Color inputFocused = _kBlueShade400;
  static const Color inputEnable = _kBlack12;
}
