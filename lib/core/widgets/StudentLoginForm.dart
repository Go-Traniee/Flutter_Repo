import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/forget_password.dart';
import 'package:gotraniee_flutter/features/student/presentation/screens/AcademicDataScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gotraniee_flutter/core/utils/validators.dart';
import 'package:gotraniee_flutter/core/widgets/custom_text_field.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/features/auth/data/models/login_request_model.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/login_cubit.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/login_state.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_cubit.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_state.dart';

import 'google_signin_button.dart';

class Studentloginform extends StatefulWidget {
  const Studentloginform({super.key});

  @override
  State<Studentloginform> createState() => _StudentloginformState();
}

class _StudentloginformState extends State<Studentloginform> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('remembered_email');
    if (savedEmail != null && mounted) {
      setState(() {
        _emailController.text = savedEmail;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid) {
      final requestModel = LoginRequestModel(
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
        isStudent: true,
      );

      context.read<LoginCubit>().login(requestModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // حقل البريد الإلكتروني: تفعيل الحالة الخضراء عند الصحة
          CustomTextField(
            hintText: 'البريد الإلكتروني',
            controller: _emailController,
            showSuccessState: true,
            prefixIconPath: 'assets/icons/Email.svg',
            validator: AppValidators.validateEmail,
            keyboardType: TextInputType.emailAddress,

          ),
          SizedBox(height: 12.h),

          // حقل كلمة المرور: تفعيل الحالة الخضراء عند الصحة
          CustomTextField(
            hintText: 'كلمة المرور',
            controller: _passwordController,
            showSuccessState: true,
            prefixIconPath: 'assets/icons/Lock (2).svg',
            isPassword: true,
            validator: AppValidators.validatePassword,
            keyboardType: TextInputType.visiblePassword,

          ),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'نسيت كلمة المرور ؟',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF718096),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'تذكرني',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF718096),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: Checkbox(
                      value: _rememberMe,
                      activeColor: const Color(0xFF011751),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50.h),

          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تسجيل الدخول بنجاح!'),
                    backgroundColor: Colors.green,
                  ),
                );

                // الانتقال إلى شاشة الطالب عند نجاح الدخول
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AcademicDataScreen()),
                      (route) => false,
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                text: state is LoginLoading ? 'جاري التحقق...' : 'تسجيل الدخول',
                onPressed: state is LoginLoading ? null : _handleSubmit,
                isLoading: state is LoginLoading,
              );
            },
          ),
          SizedBox(height: 20.h),

          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  'أو تسجيل الدخول باستخدام ',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFFA0AEC0),
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
            ],
          ),
          SizedBox(height: 16.h),

          BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthSuccess) {
                // الحساب موجود مسبقاً وسجل دخول بنجاح
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تسجيل الدخول بواسطة جوجل بنجاح!'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AcademicDataScreen()),
                      (route) => false,
                );
              } else if (state is GoogleAuthFailure) {
                // الحساب غير موجود في السيرفر أو فشل التحقق
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage), // مثل: "الحساب غير موجود، يرجى إنشاء حساب جديد"
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return GoogleSigninButton(
                isLoading: state is GoogleAuthLoading,
                onTap: () {
                  context.read<GoogleAuthCubit>().loginWithGoogle();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}