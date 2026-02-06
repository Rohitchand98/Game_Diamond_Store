import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class LeftColumn extends StatelessWidget {
  const LeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.bgDark, // Inner dark bg
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/hero_bg.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) => Container(
                height: 200,
                color: Colors.grey.shade900,
                child: const Center(
                  child: Text(
                    "Hero Image Placeholder",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildBadge(
                '✓ 24/7 Support',
                Colors.green.shade300,
                Colors.green.withValues(alpha: 0.2),
              ),
              _buildBadge(
                '✓ Secure Payment',
                Colors.blue.shade300,
                Colors.blue.withValues(alpha: 0.2),
              ),
              _buildBadge(
                '✓ Fast Delivery',
                AppTheme.accentYellow,
                AppTheme.accentYellow.withValues(alpha: 0.2),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Mobile Legends: Bang Bang', style: AppTheme.titleLarge),
          const SizedBox(height: 12),
          Text(
            'Join your friends in a brand new 5v5 MOBA showdown against real human opponents, Mobile Legends: Bang Bang! Choose your favorite heroes and build the perfect team with your comrades-in-arms!',
            style: AppTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          const Divider(color: AppTheme.inputBg),
          const SizedBox(height: 24),
          Text(
            'How to Recharge?',
            style: AppTheme.subtitle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          _buildInstructionStep(1, 'Enter your User ID and Server ID.'),
          _buildInstructionStep(2, 'Choose the package you want to buy.'),
          _buildInstructionStep(3, 'Select your preferred payment method.'),
          _buildInstructionStep(4, 'Click "Buy Now" and complete the payment.'),
          _buildInstructionStep(5, 'Diamonds will be credited shortly.'),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: bgColor,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide.none,
    );
  }

  Widget _buildInstructionStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(text, style: AppTheme.bodyMedium)),
        ],
      ),
    );
  }
}
