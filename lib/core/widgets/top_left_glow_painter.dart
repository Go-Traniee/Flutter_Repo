import 'package:flutter/material.dart';

class TopLeftGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _paintGlow(canvas, size, isRight: true);
    _paintGlow(canvas, size, isRight: false);
  }

  void _paintGlow(Canvas canvas, Size size, {required bool isRight}) {
    final double dx = isRight ? 1.0 : -1.0;

    final cornerGlowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(dx, 1.0),
        radius: 0.95,
        colors: [
          const Color(0xFFFFD768).withOpacity(0.9),
          const Color(0xFFE2A519).withOpacity(0.45),
          const Color(0xFFE2A519).withOpacity(0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), cornerGlowPaint);

    final double startX = isRight ? size.width * 0.0 : size.width * 0.15;
    final double ctrl1X = isRight ? size.width * 0.0 : -size.width * 0.0;
    final double ctrl2X = isRight ? size.width * 0.0 : -size.width * 0.0;
    final double endX = isRight ? size.width * 0.68 : size.width * 0.0;

    final Path arcPath = Path()
      ..moveTo(startX, size.height * 0.72)
      ..cubicTo(
        ctrl1X,
        size.height * 0.0,
        ctrl2X,
        size.height * 1.22,
        endX,
        size.width * 0.5,
      );

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..shader = LinearGradient(
        begin: isRight ? Alignment.centerLeft : Alignment.centerRight,
        end: Alignment.topCenter,
        colors: [
          Colors.transparent,
          const Color(0xFFE2A519).withOpacity(0.1),
          const Color(0xFFFFE897).withOpacity(0.6),
          const Color(0xFFE2A519).withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.1, 0.1, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 10, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.5);

    canvas.drawPath(arcPath, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}