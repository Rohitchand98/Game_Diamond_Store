import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class ExcitementButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;

  const ExcitementButton({
    super.key,
    required this.onPressed,
    this.label = 'Buy Now',
  });

  @override
  State<ExcitementButton> createState() => _ExcitementButtonState();
}

class _ExcitementButtonState extends State<ExcitementButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  late AnimationController _glowController;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // Scale Animation (Bounce)
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150), // Fast press down
      reverseDuration: const Duration(milliseconds: 600), // Elastic bounce back
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOut,
        reverseCurve: Curves.elasticOut, // The "Excitement" bounce
      ),
    );

    // Rotating Glow Animation (Infinite)
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _release();
    widget.onPressed();
  }

  void _onTapCancel() {
    _release();
  }

  void _release() {
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return CustomPaint(
              painter: _GlowBorderPainter(
                progress: _glowController.value,
                color: AppTheme.accentYellow,
              ),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.accentYellow,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentYellow.withValues(alpha: 0.4),
                      blurRadius: _isPressed ? 15 : 8, // Glow more on press
                      spreadRadius: _isPressed ? 2 : 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main Button Content
                    Center(
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Shine Effect Overlay
                    if (_isPressed)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withValues(alpha: 0.0),
                                  Colors.white.withValues(alpha: 0.3),
                                  Colors.white.withValues(alpha: 0.0),
                                ],
                                transform: const GradientRotation(math.pi / 4),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GlowBorderPainter extends CustomPainter {
  final double progress;
  final Color color;

  _GlowBorderPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(16));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          color.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.8), // The "light"
          color.withValues(alpha: 0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
        transform: GradientRotation(progress * 2 * math.pi),
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
