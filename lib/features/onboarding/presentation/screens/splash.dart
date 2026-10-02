import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/onboarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Onboarding1Screen(), // اسم شاشة Onboarding الخاصة بكِ
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011751), // خلفية الشاشة الكحلية
      body: Stack(
        children: [
          // 1. التوهج الشعاعي والقوس الذهبي العلوي
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(320.w, 320.h),
              painter: TopLeftGlowPainter(),
            ),
          ),

          // 2. التوهج الشعاعي والقوس الذهبي السفلي المعكوس
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: Size(320.w, 320.h),
              painter: BottomRightGlowPainter(),
            ),
          ),

          // 3. اللوجو في المنتصف
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Image.asset(
                    'assets/images/logo (2).png',
                    width: 360.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// رسم الضوء والمنحنى المضيء العلوي المطابق لفيجما
class TopLeftGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. التوهج الشعاعي الذهبي في الزاوية
    final cornerGlowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-1.0, -1.0),
        radius: 0.95,
        colors: [
          const Color(0xFFFFD768).withOpacity(0.9), // بؤرة ساطعة
          const Color(0xFFE2A519).withOpacity(0.45),
          const Color(0xFFE2A519).withOpacity(0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), cornerGlowPaint);

    // 2. القوس الانسيابي المضيء في المنتصف (بدون ملامسة الحواف)
    final Path arcPath = Path()
      ..moveTo(size.width * 0.05, size.height * 0.72) // بداية خفيفة من اليسار
      ..cubicTo(
        size.width * 0.12, size.height * 0.38, // انحناءة كروية واسعة
        size.width * 0.38, size.height * 0.12,
        size.width * 0.78, size.width * 0.05, // نهاية خفيفة للأعلى
      );

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9 // سُمك القوس
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topCenter,
        colors: [
          Colors.transparent, // يتلاشى في البداية
          const Color(0xFFE2A519).withOpacity(0.1),
          const Color(0xFFFFE897).withOpacity(0.6),
          const Color(0xFFE2A519).withOpacity(0.1),
          Colors.transparent, // يتلاشى في النهاية
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 10, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.5); // تأثير الإضاءة

    canvas.drawPath(arcPath, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// رسم الضوء والمنحنى المضيء السفلي المعكوس
class BottomRightGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. التوهج الشعاعي في الزاوية اليمنى السفلى
    final cornerGlowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(1.0, 1.0),
        radius: 0.95,
        colors: [
          const Color(0xFFFFD768).withOpacity(0.9),
          const Color(0xFFE2A519).withOpacity(0.45),
          const Color(0xFFE2A519).withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), cornerGlowPaint);

    // 2. القوس السفلي المنساب
    final Path arcPath = Path()
      ..moveTo(size.width * 0.95, size.height * 0.28)
      ..cubicTo(
        size.width * 0.88, size.height * 0.62,
        size.width * 0.62, size.height * 0.88,
        size.width * 0.22, size.height * 0.95,
      );

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9 // سُمك القوس
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.topCenter,
        colors: [
          Colors.transparent,
          const Color(0xFFE2A519).withOpacity(0.1),
          const Color(0xFFFFE897).withOpacity(0.6),
          const Color(0xFFE2A519).withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 10, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 0.5);

    canvas.drawPath(arcPath, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}