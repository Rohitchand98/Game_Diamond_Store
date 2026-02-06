import 'package:flutter/material.dart';
import '../models/package_model.dart';
import '../constants/app_theme.dart';

class PackageCard extends StatefulWidget {
  final Package pkg;
  final bool isSelected;
  final VoidCallback onTap;
  final double cardPadding;

  const PackageCard({
    super.key,
    required this.pkg,
    required this.isSelected,
    required this.onTap,
    required this.cardPadding,
  });

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
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
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isGlowing
                  ? AppTheme.accentYellow
                  : const Color(0xFF374151),
              width: isGlowing ? 2 : 2,
            ),
            boxShadow: isGlowing
                ? [
                    BoxShadow(
                      color: AppTheme.accentYellow.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                  ]
                : [],
          ),
          padding: EdgeInsets.all(widget.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.pkg.diamonds}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (widget.pkg.bonus != null && widget.pkg.bonus! > 0)
                Text(
                  '+${widget.pkg.bonus} 💎',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 4),
              if (widget.pkg.specialTag != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    widget.pkg.specialTag!,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.accentYellow,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                '₹${widget.pkg.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
