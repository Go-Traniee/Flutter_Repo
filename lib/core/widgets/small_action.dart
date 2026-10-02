import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const SmallActionButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF011751),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 16.w, color: textColor) : const SizedBox.shrink(),
      label: Text(
        text,
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: const Color(0xFFCBD5E0),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}