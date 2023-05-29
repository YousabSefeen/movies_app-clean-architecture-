import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_constants.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.grey,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white12,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: width * 0.06,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black, size: width * 0.07),
    ),
    cardTheme: CardTheme(
        elevation: 20,
        color: Colors.white,
        margin: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.red,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: width * 0.04,
        )),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: width * 0.07,
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: width * 0.06,
          color: const Color(0xff0d1b2a),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      bodyMedium: TextStyle(
        ///  use in  Details  (release Date  && runtime)
        fontSize: width * 0.05,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: width * 0.04,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle: TextStyle(
          ///  use in  Details  (Genres  && MoreLikeThis)
          fontSize: width * 0.04,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w800,
          color: const Color(0xff0d1b2a),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: const Color(0xff0d1b2a),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff0d1b2a),
      titleTextStyle: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: width * 0.06,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white, size: width * 0.07),
    ),
    cardTheme: CardTheme(
        elevation: 20,
        color: const Color(0xff1b263b),
        margin: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.red,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: width * 0.04,
        )),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: width * 0.07,
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: width * 0.06,
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      // bodySmall: AppFontsDarkMode.overviewStyle,
      bodyMedium: TextStyle(
        ///  use in  Details  (release Date  && runtime)
        fontSize: width * 0.05,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: width * 0.04,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: Colors.white70,
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle: TextStyle(
          ///  use in  Details  (Genres  && MoreLikeThis)
          fontSize: width * 0.04,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  );
}
