import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/package_model.dart';

class DataService {
  static Future<List<Package>> loadPackages() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/packages.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Package.fromJson(json)).toList();
    } catch (e) {
      // Fallback or error logging
      debugPrint("Error loading packages: $e");
      return [];
    }
  }
}
