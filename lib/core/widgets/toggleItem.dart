import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleItem extends StatelessWidget {
  final bool isStudentSelected;
  final ValueChanged<bool> onToggle;

  const ToggleItem({
    super.key,
    required this.isStudentSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E9F0), // لون الخلفية الرمادي الفاتح من Figma[cite: 11]
        borderRadius: BorderRadius.circular(50.r), // زوايا دائرية 50 من Figma[cite: 10, 11]
        border: Border.all(
          color: const Color(0xFFD9D9D9), // الإطار الخارجي من Figma[cite: 10, 11]
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          // خيار: مؤسسة / شركة
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isStudentSelected
                      ? const Color(0xFF011751) // اللون الكحلي الغامق عند الاختيار[cite: 10]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  'مؤسسة / شركة',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: !isStudentSelected
                        ? Colors.white
                        : const Color(0xFF011751),
                  ),
                ),
              ),
            ),
          ),

          // خيار: طالب
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isStudentSelected
                      ? const Color(0xFF011751) // اللون الكحلي الغامق عند الاختيار[cite: 10]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  'طالب',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isStudentSelected
                        ? Colors.white
                        : const Color(0xFF011751),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}