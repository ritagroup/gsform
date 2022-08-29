import 'package:flutter/material.dart';

import 'colors.dart';

class GSFormTheme {
  static TextTheme textThemeStyle = const TextTheme(
    headline1: TextStyle(color: GSFormColors.textColorHeader, fontWeight: FontWeight.w700, fontSize: 12.0),
    headline2: TextStyle(color: GSFormColors.textColor, fontWeight: FontWeight.w700, fontSize: 11.0),
    headline3: TextStyle(color: GSFormColors.hintTextColor, fontWeight: FontWeight.w500, fontSize: 9.0),
    headline4: TextStyle(color: GSFormColors.hintTextColor, fontWeight: FontWeight.w400, fontSize: 7.0),
    headline5: TextStyle(color: GSFormColors.red, fontWeight: FontWeight.w400, fontSize: 7.0),
  );

  static TextTheme textThemeDarkStyle = const TextTheme(
    headline1: TextStyle(color: GSFormColors.textDarkColorHeader, fontWeight: FontWeight.w700, fontSize: 12.0),
    headline2: TextStyle(color: GSFormColors.textColorDark, fontWeight: FontWeight.w700, fontSize: 11.0),
    headline3: TextStyle(color: GSFormColors.textColorDark, fontWeight: FontWeight.w500, fontSize: 9.0),
    headline4: TextStyle(color: GSFormColors.hintTextDarkColor, fontWeight: FontWeight.w400, fontSize: 7.0),
    headline5: TextStyle(color: GSFormColors.red, fontWeight: FontWeight.w400, fontSize: 7.0),
  );
}
