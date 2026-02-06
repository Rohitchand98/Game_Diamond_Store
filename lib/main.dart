import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/screens/diamond_store_screen.dart';
import 'src/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed: $e");
  }
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const HarisdiamApp(),
    ),
  );
}

class HarisdiamApp extends StatelessWidget {
  const HarisdiamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zimutzofficialstore | MLBB Top-up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1120), // Deep Dark Blue
        primaryColor: const Color(0xFFEBC169), // Gold
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFEBC169),
          secondary: Color(0xFF00C8F0), // Cylinder Blue
          surface: Color(0xFF151A2D), // Card Background
        ),
        textTheme: GoogleFonts.rajdhaniTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F263A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF00C8F0), width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
      home: const DiamondStoreScreen(),
    );
  }
}
