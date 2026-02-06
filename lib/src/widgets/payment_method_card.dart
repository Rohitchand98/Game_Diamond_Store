import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class PaymentMethodCard extends StatefulWidget {
  final String method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isGlowing = widget.isSelected || _isHovered;
    final scale = _isHovered ? 1.05 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.diagonal3Values(scale, scale, 1.0),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: widget.isSelected ? AppTheme.accentIndigo : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isGlowing
                  ? AppTheme.accentIndigo
                  : const Color(0xFF374151),
              width: 2,
            ),
            boxShadow: isGlowing
                ? [
                    BoxShadow(
                      color: AppTheme.accentIndigo.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.method,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
