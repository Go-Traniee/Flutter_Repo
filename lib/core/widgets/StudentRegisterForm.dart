import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/network/service_locator.dart';
import 'package:gotraniee_flutter/core/utils/validators.dart';
import 'package:gotraniee_flutter/core/widgets/custom_text_field.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/features/auth/data/models/register_request_model.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/register_cubit.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/register_state.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_cubit.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_state.dart';
import 'package:gotraniee_flutter/features/student/presentation/screens/AcademicDataScreen.dart';

import 'google_signin_button.dart';

//يبني الطلب ويستدعي الكيوبت
class StudentRegisterForm extends StatefulWidget {
  const StudentRegisterForm({super.key});

  @override
  State<StudentRegisterForm> createState() => _StudentRegisterFormState();
}

class _StudentRegisterFormState extends State<StudentRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isAgreed = false;
  bool _showAgreeError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final isFormValid = _formKey.currentState!.validate();
    setState(() => _showAgreeError = !_isAgreed);

    if (isFormValid && _isAgreed) {
      final requestModel = RegisterRequestModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        isStudent: true,
      );
      context.read<RegisterCubit>().register(requestModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.response.message)),
          );

          // الانتقال لشاشة إكمال البروفايل للطالب عند نجاح التسجيل
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AcademicDataScreen()),
                (route) => false,
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // حقل الاسم: عادي (سكني -> كحلي عند التركيز) بدون حالة الصح الأخضر
            CustomTextField(
              hintText: 'الاسم بالكامل',
              controller: _nameController,
              prefixIconPath: 'assets/icons/person.svg',
              keyboardType: TextInputType.text,


              validator: (val) =>
                  AppValidators.validateRequired(val, fieldName: 'الاسم'),
            ),
            SizedBox(height: 12.h),
            // حقل البريد: يتفعل للون الأخضر والصح عند القيمة الصحيحة
            CustomTextField(
              hintText: 'البريد الإلكتروني',
              controller: _emailController,
              showSuccessState: true,
              prefixIconPath: 'assets/icons/Email.svg',
              validator: AppValidators.validateEmail,
              keyboardType: TextInputType.emailAddress,

            ),
            SizedBox(height: 12.h),
            // حقل كلمة المرور: يتفعل للون الأخضر والصح عند القيمة الصحيحة
            CustomTextField(
              hintText: 'كلمة المرور',
              controller: _passwordController,
              showSuccessState: true,
              prefixIconPath: 'assets/icons/Lock (2).svg',
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,

              validator: AppValidators.validatePassword,
            ),
            SizedBox(height: 12.h),
            // حقل تأكيد كلمة المرور: يتفعل للون الأخضر والصح عند التطابق
            CustomTextField(
              hintText: 'تأكيد كلمة المرور',
              controller: _confirmPasswordController,
              showSuccessState: true,
              keyboardType: TextInputType.visiblePassword,

              prefixIconPath: 'assets/icons/Lock (2).svg',
              isPassword: true,
              validator: (val) => AppValidators.validateConfirmPassword(
                val,
                _passwordController.text,
              ),
            ),

            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'أوافق',
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
                    value: _isAgreed,
                    activeColor: const Color(0xFF011751),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value ?? false;
                        if (_isAgreed) _showAgreeError = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_showAgreeError)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'يجب الموافقة على الشروط أولاً',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFE53E3E),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 16.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return PrimaryButton(
                  text: 'إنشاء حساب',
                  isLoading: state is RegisterLoading,
                  onPressed: state is RegisterLoading ? null : _handleSubmit,
                );
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                const Expanded(
                  child: Divider(color: Color(0xFFCBD5E0), thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'أو تسجيل الدخول باستخدام',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFFA0AEC0),
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(color: Color(0xFFCBD5E0), thickness: 1),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            BlocProvider(
              create: (_) => getIt<GoogleAuthCubit>(),
              child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
                listener: (context, state) {
                  if (state is GoogleAuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الدخول باستخدام Google بنجاح')),
                    );

                    // الانتقال لشاشة إكمال البروفايل للطالب عند نجاح التسجيل عبر Google
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const AcademicDataScreen()),
                          (route) => false,
                    );
                  } else if (state is GoogleAuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return GoogleSigninButton(
                    onTap: () {
                      context.read<GoogleAuthCubit>().loginWithGoogle();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


















/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/network/service_locator.dart';
import 'package:gotraniee_flutter/core/utils/validators.dart';
import 'package:gotraniee_flutter/core/widgets/custom_text_field.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/features/auth/data/models/register_request_model.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/register_cubit.dart';
import 'package:gotraniee_flutter/features/auth/presentation/controllers/register_state.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_cubit.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/controllers/google_auth_state.dart';

import 'google_signin_button.dart';
//يبني الطلب ويستدعي الكيوبت
class StudentRegisterForm extends StatefulWidget {
  const StudentRegisterForm({super.key});

  @override
  State<StudentRegisterForm> createState() => _StudentRegisterFormState();
}

class _StudentRegisterFormState extends State<StudentRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isAgreed = false;
  bool _showAgreeError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final isFormValid = _formKey.currentState!.validate();
    setState(() => _showAgreeError = !_isAgreed);

    if (isFormValid && _isAgreed) {
      final requestModel = RegisterRequestModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        isStudent: true,
      );
      context.read<RegisterCubit>().register(requestModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.response.message)),
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              hintText: 'الاسم بالكامل',
              controller: _nameController,
              prefixIconPath: 'assets/icons/person.svg',
              validator: (val) =>
                  AppValidators.validateRequired(val, fieldName: 'الاسم'),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: 'البريد الإلكتروني',
              controller: _emailController,
              prefixIconPath: 'assets/icons/Email.svg',
              validator: AppValidators.validateEmail,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: 'كلمة المرور',
              controller: _passwordController,
              prefixIconPath: 'assets/icons/Lock (2).svg',
              isPassword: true,
              validator: AppValidators.validatePassword,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: 'تأكيد كلمة المرور',
              controller: _confirmPasswordController,
              prefixIconPath: 'assets/icons/Lock (2).svg',
              isPassword: true,
              validator: (val) => AppValidators.validateConfirmPassword(
                val,
                _passwordController.text,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'أوافق',
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
                    value: _isAgreed,
                    activeColor: const Color(0xFF011751),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value ?? false;
                        if (_isAgreed) _showAgreeError = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_showAgreeError)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'يجب الموافقة على الشروط أولاً',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFE53E3E),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 16.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return PrimaryButton(
                  text: 'إنشاء حساب',
                  isLoading: state is RegisterLoading,
                  onPressed: state is RegisterLoading ? null : _handleSubmit,
                );
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                const Expanded(
                  child: Divider(color: Color(0xFFCBD5E0), thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'أو تسجيل الدخول باستخدام',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFFA0AEC0),
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(color: Color(0xFFCBD5E0), thickness: 1),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            BlocProvider(
              create: (_) => getIt<GoogleAuthCubit>(),
              child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
                listener: (context, state) {
                  if (state is GoogleAuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الدخول باستخدام Google بنجاح')),
                    );
                  } else if (state is GoogleAuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return GoogleSigninButton(
                    onTap: () {
                      context.read<GoogleAuthCubit>().loginWithGoogle();
                    },
                  );
                },
              ),
            )          ],
        ),
      ),
    );
  }
}

* */