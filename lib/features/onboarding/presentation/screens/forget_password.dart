



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/utils/validators.dart';
import 'package:gotraniee_flutter/core/widgets/custom_text_field.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/core/widgets/top_left_glow_painter.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/verify_Screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyOtpScreen(email: _emailController.text.trim()),
        ),
      );
    }
  }


  /*void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      // TODO: إرسال الرمز والانتقال لشاشة الـ OTP
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
                  top: 0, left: 0, right: 0,
                  height: topHeight,
                  child: CustomPaint(
                    painter: TopLeftGlowPainter(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Image.asset('assets/images/logo (2).png',
                          width: 210.w,
                          fit: BoxFit.contain,
                        ),),),),),
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
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF011751),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'أدخل بريدك الإلكتروني المسجل لإرسال رمز\nالتحقق وإعادة ضبط كلمة المرور.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  height: 1.5,
                                  color: const Color(0xFF718096),),),
                              SizedBox(height: 36.h),
                              CustomTextField(
                                hintText: 'البريد الالكتروني',
                                controller: _emailController,
                                prefixIconPath: 'assets/icons/Email.svg',
                                validator: AppValidators.validateEmail,
                              ),
                              SizedBox(height: 36.h),
                              PrimaryButton(
                                text: 'ارسال رمز التحقق',
                                onPressed: _handleSendOtp,),

                              SizedBox(height: 24.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF011751),),),),

                                  Text(
                                    'تذكرت كلمة المرور؟ ',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF718096)
                                      ,),),],),],),),),),),),],);},),),);}}

