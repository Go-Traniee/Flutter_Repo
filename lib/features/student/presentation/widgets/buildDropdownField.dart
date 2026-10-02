import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final String iconPath;
  final IconData fallbackIcon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?) validator;
  final AutovalidateMode? autovalidateMode;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.iconPath,
    required this.fallbackIcon,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.validator,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value != null && value!.isNotEmpty;

    return DropdownButtonFormField<String>(
      value: (value != null && items.contains(value)) ? value : null,
      autovalidateMode: autovalidateMode,
      alignment: AlignmentDirectional.topEnd,
      items: items
          .map((e) => DropdownMenuItem<String>(
        value: e,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            e,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF2D3748),
            ),),),)).toList(),
      onChanged: onChanged,
      validator: validator,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: isSelected ? Colors.green : const Color(0xFFA0AEC0),
        size: 22.w,
      ),
      dropdownColor: Colors.white,
      menuMaxHeight: 250.h,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13.sp, color: const Color(0xFFA0AEC0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: Image.asset(
            iconPath,
            width: 20.w,
            height: 20.h,
            color: isSelected ? Colors.green : null,
            errorBuilder: (_, __, ___) => Icon(
              fallbackIcon,
              size: 20.w,
              color: isSelected ? Colors.green : const Color(0xFFA0AEC0),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isSelected ? Colors.green : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: isSelected ? Colors.green : const Color(0xFF011751),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}