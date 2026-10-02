import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/utils/validators.dart';
import 'package:gotraniee_flutter/core/widgets/custom_text_field.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/core/widgets/top_left_glow_painter.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false, // يمسح كل الشاشات السابقة، ما تقدري ترجعي بزر الرجوع
      );
    }
  }
  /*void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: حفظ كلمة المرور وتوجيه المستخدم لتسجيل الدخول
    }
  }*/

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
                          horizontal: 24.w,
                          vertical: 28.h,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                'كلمة المرور الجديدة',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF011751),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'أنشئ كلمة مرور جديدة وقوية لحسابك.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF718096),
                                ),
                              ),
                              SizedBox(height: 32.h),
                              CustomTextField(
                                hintText: 'كلمة المرور الجديدة',
                                controller: _passwordController,
                                prefixIconPath: 'assets/icons/Lock (2).svg',
                                isPassword: true,
                                validator: AppValidators.validatePassword,
                              ),
                              SizedBox(height: 14.h),
                              CustomTextField(
                                hintText: 'تأكيد كلمة المرور الجديدة',
                                controller: _confirmPasswordController,
                                prefixIconPath: 'assets/icons/Lock (2).svg',
                                isPassword: true,
                                validator: (val) =>
                                    AppValidators.validateConfirmPassword(
                                      val,
                                      _passwordController.text,
                                    ),
                              ),
                              SizedBox(height: 32.h),
                              PrimaryButton(
                                text: 'حفظ وتغيير كلمة المرور',
                                onPressed: _handleResetPassword,
                              ),
                            ],
                          ),
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