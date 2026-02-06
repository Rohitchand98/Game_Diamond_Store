import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Text(
        '© 2026 Mobile Legends Diamond Store. All rights reserved.',
        style: TextStyle(color: AppTheme.textGray, fontSize: 12),
      ),
    );
  }
}
