
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme= ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      //to allow me to customize my system app
        statusBarColor: HexColor('333739'),
        statusBarBrightness: Brightness.light),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.white),
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme= ThemeData(
  indicatorColor: Colors.deepOrange,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      //to allow me to customize my system app
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black),
  ),
  fontFamily: 'Jannah',
);