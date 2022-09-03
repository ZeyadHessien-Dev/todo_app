import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'color.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: defaultColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    headline5: TextStyle(
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('57504F'),
  primaryColor: defaultColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor:  Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
    color: HexColor('57504F'),
    titleTextStyle: const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('57504F'),
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    headline5: TextStyle(
      color: Colors.white,
    ),
  ),
);
