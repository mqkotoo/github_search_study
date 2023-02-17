import 'package:flutter/material.dart';

//light theme ----------------------------------
ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xffFCFDF6),

  //appbar theme
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xffFCFDF6),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  //textField theme
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    fillColor: const Color(0xffe1eedf),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
  ),
  // divider
  dividerColor: Colors.black12,

  //詳細テキスト用
  hoverColor: Colors.grey.shade800,
);

//dark theme ----------------------------------
ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xff1A1C19),
  //appbar theme
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xff1A1C19),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  //textField theme
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    fillColor: const Color(0xff454f45),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    ),
  ),

  // divider
  dividerColor: const Color(0xff777777),

  //詳細テキスト用
  hoverColor: const Color(0xffBBBBBB),
);