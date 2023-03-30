import 'package:flutter/material.dart';

abstract class ProjectColors {
  static const Color textColorPrimary = _black;

  static const Color textColorSecondary = _grey;

  static const Color activeColor = _blue;

  static const Color iconColor = _white;

  static const Color btnColor = _black;

  static const Color screenBackgroundColor = _brightGrey;

  static const Color inputBackgroundColor = _greyTr;



  /// color scheme
  static const Color _brightGrey = Color.fromRGBO(247, 248, 250, 1);

  static const Color _black = Color.fromRGBO(0, 0, 0, 1);

  static const Color _grey = Color.fromRGBO(115, 115, 115, 1);

  static const Color _white = Color.fromRGBO(250, 250, 250, 1);

  static const Color _blue = Color.fromRGBO(52, 120, 246, 1);

  static const Color _greyTr = Color.fromRGBO(118, 118, 128, 0.12);
}
