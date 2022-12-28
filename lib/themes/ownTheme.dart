import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();
  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: mainOrange),
        elevation: 0,
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: GoogleFonts.roboto(fontSize: 15, color: mainOrange),
        bodySmall: GoogleFonts.roboto(fontSize: 14, color: lightGrey),
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: mainOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      colorScheme: const ColorScheme.light(
        primary: mainOrange, // header background color
        onSurface: mainOrange, // body text color
      ),
    );
  }
}


//roboto-regular

/*
* headline1: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: mainBlue
        ),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.grey
        )
*
*
* */