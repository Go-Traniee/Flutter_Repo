import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String prefixIconPath;
  final String? suffixIconPath;
  final VoidCallback? onSuffixTap;
  final bool isPassword;
  final String? errorText; // لو مش null → نص أحمر تحت الحقل + بوردر أحمر
  final String? successText; // لو مش null (وما فيه errorText) → نص أخضر + بوردر أخضر

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIconPath,
    this.suffixIconPath,
    this.onSuffixTap,
    this.isPassword = false,
    this.errorText,
    this.successText,
  });

  static const Color _greyBorder = Color(0xFFD1D5DB);
  static const Color _navy = Color(0xFF011751);
  static const Color _red = Color(0xFFDC2626);
  static const Color _green = Color(0xFF149C2F);

  @override
  Widget build(BuildContext context) {
    // نجاح فقط إذا في successText وما في إيرور
    final bool isSuccess = errorText == null && successText != null;

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF9CA3AF),
        ),
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 8.w),
          child: SvgPicture.asset(
            prefixIconPath,
            width: 16.w,
            height: 13.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.w,
          minHeight: 20.h,
        ),
        suffixIcon: suffixIconPath != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: SvgPicture.asset(
              suffixIconPath!,
              width: 23.w,
              height: 17.h,
              fit: BoxFit.contain,
            ),
          ),
        )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        // الحالة العادية: رمادي، وأخضر لو نجاح
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isSuccess ? _green : _greyBorder,
            width: isSuccess ? 1.2 : 1,
          ),
        ),

        // لما يضغط عليه (فوكس): كحلي، وأخضر لو نجاح
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isSuccess ? _green : _navy,
            width: 1.5,
          ),
        ),

        // إيرور
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: _red, width: 1.2),
        ),

        // إيرور + فوكس
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: _red, width: 1.5),
        ),

        errorText: errorText,
        errorStyle: TextStyle(fontSize: 12.sp, color: _red),

        helperText: isSuccess ? successText : null,
        helperStyle: TextStyle(fontSize: 12.sp, color: _green),
      ),
    );
  }
}