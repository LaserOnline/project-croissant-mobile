import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

ThemeData configTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      background: Color(0xff00224D),
      secondary: Color(0xff9BCF53),
      primary: Color(0xffFF204E),
      surface: Colors.white,
      error: Color(0xffFF204E),
      scrim: Color(0xffEEEEEE),
      tertiary: Color(0xff000000),
      inversePrimary: Color(0xff161A30),
      secondaryContainer: Colors.white,
      errorContainer: Color(0xffF15A59),
      primaryContainer: Color(0xffFFC000),
      onBackground: Color(0xff00224D),
      onPrimary: Color(0xff31363F),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: const Color(0xffFF204E),
        borderRadius: BorderRadius.circular(1),
      ),
      unselectedLabelColor: const Color(0xff31363F),
      unselectedLabelStyle: const TextStyle(color: Colors.white),
    ),
    textTheme: GoogleFonts.kanitTextTheme(),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: const Color(0xffEEEEEE),
          fontSize: Adaptive.h(1.5),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
