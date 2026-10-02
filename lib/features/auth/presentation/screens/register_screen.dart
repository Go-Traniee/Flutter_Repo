import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotraniee_flutter/core/widgets/CompanyRegisterForm.dart';
import 'package:gotraniee_flutter/core/widgets/StudentRegisterForm.dart';
import 'package:gotraniee_flutter/core/widgets/toggleItem.dart';
import 'package:gotraniee_flutter/core/widgets/top_left_glow_painter.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/login_screen.dart';
import '../controllers/register_cubit.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../data/repositories/register_repository_impl.dart';
import '../../data/datasources/register_remote_datasource.dart';
//الشاشة يلي بتحط الـBlocProvider وتستدعي الفورمات
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isStudentSelected = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        RegisterUseCase(
          RegisterRepositoryImpl(
            RegisterRemoteDataSourceImpl(Dio()),
            const FlutterSecureStorage(),

          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF011751),
        body: SafeArea(
          top: false,
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double topHeight = constraints.maxHeight * 0.27;
              final double cardTop = constraints.maxHeight * 0.205;

              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: topHeight,
                    child: CustomPaint(
                      painter: TopLeftGlowPainter(),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Image.asset(
                            'assets/images/logo (2).png',
                            width: 210.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: cardTop,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(36.r),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(36.r),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              ToggleItem(
                                isStudentSelected: _isStudentSelected,
                                onToggle: (value) {
                                  setState(() => _isStudentSelected = value);
                                },
                              ),
                              SizedBox(height: 18.h),
                              Column(
                                children: [
                                  Visibility(
                                    visible: _isStudentSelected,
                                    maintainState: true,
                                    child: const StudentRegisterForm(),
                                  ),
                                  Visibility(
                                    visible: !_isStudentSelected,
                                    maintainState: true,
                                    child: const CompanyRegisterForm(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LoginScreen(
                                            initialIsStudent: _isStudentSelected,),),);},
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF011751),),),),
                                  Text(
                                    'يوجد لديك حساب؟ ',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF718096),
                                    ),
                                  ),
                                  ],),],),),),),),],);},),),),);}}




























/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/widgets/CompanyRegisterForm.dart';
import 'package:gotraniee_flutter/core/widgets/StudentRegisterForm.dart';
import 'package:gotraniee_flutter/core/widgets/toggleItem.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isStudentSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011751),
      body: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double topHeight = constraints.maxHeight * 0.27;
            final double cardTop = constraints.maxHeight * 0.205;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: topHeight,
                  child: CustomPaint(
                    painter: TopLeftGlowPainter(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Image.asset(
                          'assets/images/logo (2).png',
                          width: 210.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: cardTop,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(36.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(36.r),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          children: [
                            ToggleItem(
                              isStudentSelected: _isStudentSelected,
                              onToggle: (value) {
                                setState(() {
                                  _isStudentSelected = value;
                                });
                              },
                            ),
                            SizedBox(height: 18.h),

                            Column(
                              children: [
                                Visibility(
                                  visible: _isStudentSelected,
                                  maintainState: true,
                                  child: const StudentRegisterForm(),
                                ),
                                Visibility(
                                  visible: !_isStudentSelected,
                                  maintainState: true,
                                  child: const CompanyRegisterForm(),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginScreen(
                                          initialIsStudent: _isStudentSelected,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF011751),
                                    ),
                                  ),
                                ),
                                Text(
                                  'يوجد لديك حساب؟ ',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF718096),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// الرسام الشعاعي الخلفي — يمين ويسار (معكوس)
class TopLeftGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _paintGlow(canvas, size, isRight: true);
    _paintGlow(canvas, size, isRight: false);
  }

  void _paintGlow(Canvas canvas, Size size, {required bool isRight}) {
    final double dx = isRight ? 1.0 : -1.0;

    // الذهبي
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

    // القوس
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
}*/