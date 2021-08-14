import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'PoppinsNormal',
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Color(0xffF8F9FD),
  primaryColor: Colors.white,
  primaryColorDark: Colors.black,
  // primaryColorLight: Color(0xfff699cd),
  // // primaryIconTheme: IconThemeData(color: Colors.red[900]),
  // buttonColor: Color(0xfff699cd),
//   Color pink = Color(0xfffe81cc);
// Color pink1 = Color(0xffff69b4);
// Color pink3 = Color(0xfffa86c4);
// Color pink4 = Color(0xfff699cd);
// Color pink5 = Color(0xffff45b5);
// Color pink6 = Color(0xfff987c5);
// Color pink7 = Color(0xfffe5bac);
// Color pink8 = Color(0xfff699cd);
  appBarTheme: AppBarTheme(
    // textTheme: TextTheme.lerp(2, 2, t),
    shadowColor: Colors.grey,
    color: Colors.white,
    elevation: 0.0,
  ),
  // primaryColor: Color(0xffFFA6C9),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    subtitle2: TextStyle(fontFamily: 'Poppins',fontSize: 12),
    headline3: TextStyle(),
    headline5: TextStyle(color: Colors.white),
    headline6: TextStyle(),
    caption: TextStyle(),
    overline: TextStyle(),
  )
);

