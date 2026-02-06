import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final Widget logo;
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  const HeaderSection({
    super.key,
    required this.logo,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    required this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        logo,
        const SizedBox(height: 12),
        Text(title, style: titleStyle),
        Text(subtitle, style: subtitleStyle),
      ],
    );
  }
}
