import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/core/widgets/top_left_glow_painter.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/reset_password_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, this.email = 'm.abujadallah@eiu.edu.ps'});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleVerify() {
    final otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
      );
    }
  }
  /*void _handleVerify() {
    final otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      // TODO: الانتقال لشاشة تغيير كلمة المرور
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              'رمز التحقق',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF011751),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'أدخل الرمز المكون من 4 أرقام المرسل إلى:',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF718096),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.email,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF011751),
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // مربعات إدخال أرقام الـ OTP الاربعة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(4, (index) {
                                return SizedBox(
                                  width: 60.w,
                                  height: 60.h,
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF011751),
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(12.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(12.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF011751),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty && index < 3) {
                                        _focusNodes[index + 1].requestFocus();
                                      } else if (value.isEmpty && index > 0) {
                                        _focusNodes[index - 1].requestFocus();
                                      }
                                    },
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'لم يصلك الرمز؟ إعادة إرسال خلال 00:45',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFFA0AEC0),
                              ),
                            ),
                            SizedBox(height: 28.h),
                            PrimaryButton(
                              text: 'تأكيد الرمز',
                              onPressed: _handleVerify,
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