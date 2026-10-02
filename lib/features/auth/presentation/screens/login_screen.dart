import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:gotraniee_flutter/core/widgets/CompanyLoginForm.dart';
import 'package:gotraniee_flutter/core/widgets/StudentLoginForm.dart';
import 'package:gotraniee_flutter/core/widgets/toggleItem.dart';
import 'package:gotraniee_flutter/core/widgets/top_left_glow_painter.dart';

// استدعاء ملفات الـ Cubits الخاصة بالـ Auth
import 'package:gotraniee_flutter/features/auth/presentation/controllers/login_cubit.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  final bool initialIsStudent;
  const LoginScreen({super.key, this.initialIsStudent = true});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _isStudentSelected;

  @override
  void initState() {
    super.initState();
    _isStudentSelected = widget.initialIsStudent;
  }

  @override
  Widget build(BuildContext context) {
    // 💡 توفير كلاً من LoginCubit و GoogleAuthCubit باستخدام MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<GoogleAuthCubit>(),
        ),
      ],
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
                                  setState(() {
                                    _isStudentSelected = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                children: [
                                  Visibility(
                                    visible: _isStudentSelected,
                                    maintainState: true,
                                    child: const Studentloginform(),
                                  ),
                                  Visibility(
                                    visible: !_isStudentSelected,
                                    maintainState: true,
                                    child: const CompanyLoginForm(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Text(
                                      'إنشاء حساب جديد',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF011751),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ليس لديك حساب؟ ',
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
      ),
    );
  }
}

