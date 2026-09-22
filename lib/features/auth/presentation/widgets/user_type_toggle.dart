import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/user_type.dart';

class UserTypeToggle extends StatelessWidget {
  final UserType selected;
  final ValueChanged<UserType> onChanged;

  const UserTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const Color _background = Color(0xFFE3E9F0);
  static const Color _border = Color(0xFFD9D9D9);
  static const Color _navy = Color(0xFF011751);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.5.h),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: _border, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // أول عنصر بيظهر يمين لأنو الاتجاه RTL
          _buildItem('طالب', UserType.student),
          _buildItem('مؤسسة / شركة', UserType.company),
        ],
      ),
    );
  }

  Widget _buildItem(String label, UserType type) {
    final bool isSelected = selected == type;

    return Flexible(
      child: GestureDetector(
        onTap: () => onChanged(type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 150.w,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? _navy : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(
              color: isSelected ? _border : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : _navy,
            ),
          ),
        ),
      ),
    );
  }
}