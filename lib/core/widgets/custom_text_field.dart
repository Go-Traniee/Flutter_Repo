import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String prefixIconPath;
  final bool isPassword;
  final bool showSuccessState; // Control green success indicator
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIconPath,
    this.isPassword = false,
    this.showSuccessState = false, // Default is false (Normal state)
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isSuccess = false;

  static const Color _navy = Color(0xFF011751);
  static const Color _greyBorder = Color(0xFFE2E8F0);
  static const Color _hintGrey = Color(0xFFA0AEC0);
  static const Color _success = Color(0xFF10B981);
  static const Color _error = Color(0xFFE53E3E);

  void _evaluateSuccess(String value) {
    if (!widget.showSuccessState || widget.validator == null) return;
    final error = widget.validator!(value);
    final success = error == null && value.trim().isNotEmpty;
    if (success != _isSuccess) {
      setState(() => _isSuccess = success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isApproved = widget.showSuccessState && _isSuccess;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && _obscureText,
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        onChanged: (value) {
          widget.onChanged?.call(value);
          _evaluateSuccess(value);
        },
        cursorColor: _navy,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14.sp, color: _navy),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: _hintGrey),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: SvgPicture.asset(widget.prefixIconPath, width: 20.w, height: 20.h),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),

          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Icon(
                _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20.w,
                color: isApproved ? _success : _hintGrey,
              ),
            ),
          )
              : (isApproved
              ? Icon(Icons.check_circle, color: _success, size: 20.w)
              : null),
          suffixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          errorStyle: TextStyle(fontSize: 12.sp, color: _error, height: 1.2),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: isApproved ? _success : _greyBorder,
              width: isApproved ? 1.5 : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: isApproved ? _success : _navy,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _error, width: 1.5),
          ),
        ),
      ),
    );
  }
}