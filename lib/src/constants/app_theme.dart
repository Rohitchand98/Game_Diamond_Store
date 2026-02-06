import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color bgDark = Color(0xFF111827); // Gray 900
  static const Color cardBg = Color(0xFF1f2937); // Gray 800
  static const Color accentYellow = Color(0xFFfacc15); // Yellow 400
  static const Color accentIndigo = Color(0xFF4f46e5); // Indigo 600
  static const Color textGray = Color(0xFF9ca3af); // Gray 400
  static const Color inputBg = Color(0xFF374151); // Gray 700

  // Text Styles
  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14, color: textGray, height: 1.5);

  static TextStyle get subtitle =>
      GoogleFonts.inter(fontSize: 18, color: textGray);

  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: bgDark,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark(
        primary: accentIndigo,
        secondary: accentYellow,
        surface: cardBg,
      ),
    );
  }
}
