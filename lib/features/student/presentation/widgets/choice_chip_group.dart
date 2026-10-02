import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceChipOption {
  final String label;
  final String value;
  const ChoiceChipOption({required this.label, required this.value});
}

class ChoiceChipGroup extends StatelessWidget {
  final List<ChoiceChipOption> options;
  final List<String> selectedValues; // ✅ List عشان تدعم اختيار واحد أو متعدد
  final ValueChanged<String> onToggle;
  final bool isMultiSelect;

  const ChoiceChipGroup({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onToggle,
    this.isMultiSelect = false,
  });

  static const Color _navy = Color(0xFF011751);
  static const Color _greyBorder = Color(0xFFE2E8F0);
  static const Color _greyText = Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option.value);
        return GestureDetector(
          onTap: () => onToggle(option.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? _navy : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected ? _navy : _greyBorder,
                width: 1,
              ),
            ),
            child: Text(
              option.label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : _greyText,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}