import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/student/data/models/availability_request_model.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/availability_cubit.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/choice_chip_group.dart';

class AvailabilityBottomSheet extends StatefulWidget {
  const AvailabilityBottomSheet({super.key});

  @override
  State<AvailabilityBottomSheet> createState() => _AvailabilityBottomSheetState();
}

class _AvailabilityBottomSheetState extends State<AvailabilityBottomSheet> {
  static const Color _navy = Color(0xFF011751);
  static const Color _greyBorder = Color(0xFFE2E8F0);
  static const Color _greyText = Color(0xFF718096);

  String? _selectedWorkType;
  String? _selectedHours;
  final List<String> _selectedDays = [];

  static const _workTypeOptions = [
    ChoiceChipOption(label: '(Remote) عن بُعد', value: 'remote'),
    ChoiceChipOption(label: '(On-site) حضوري', value: 'on_site'),
    ChoiceChipOption(label: '(Hybrid) هجين', value: 'hybrid'),
  ];

  static const _hoursOptions = [
    ChoiceChipOption(label: '5 - 10 ساعات', value: '5-10'),
    ChoiceChipOption(label: '10 - 15 ساعة', value: '10-15'),
    ChoiceChipOption(label: '+20 ساعة', value: '20+'),
  ];

  static const _daysOptions = [
    ChoiceChipOption(label: 'السبت', value: 'saturday'),
    ChoiceChipOption(label: 'الأحد', value: 'sunday'),
    ChoiceChipOption(label: 'الاثنين', value: 'monday'),
    ChoiceChipOption(label: 'الثلاثاء', value: 'tuesday'),
    ChoiceChipOption(label: 'الأربعاء', value: 'wednesday'),
    ChoiceChipOption(label: 'الخميس', value: 'thursday'),
  ];

  bool get _canSubmit =>
      _selectedWorkType != null && _selectedHours != null && _selectedDays.isNotEmpty;

  void _handleFinish() {
    if (!_canSubmit) return;
    final request = AvailabilityRequestModel(
      workType: _selectedWorkType!, hours: _selectedHours!, days: _selectedDays,
    );
    context.read<AvailabilityCubit>().save(request);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality( // ✅ التصحيح الأساسي
      textDirection: TextDirection.rtl,
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _greyBorder,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close, color: _greyText),
                          ),
                          const Spacer(),
                        ]),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('الجاهزية وأوقات التوفر',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy)),
                        ),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('طبيعة العمل المفضلة',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy)),
                        ),
                        SizedBox(height: 10.h),
                        // ✅ نفس نمط ChoiceChipGroup (موحّد مع الساعات والأيام)، بس Wrap يسمح بعرض كامل
                        ..._workTypeOptions.map((option) {
                          final isSelected = _selectedWorkType == option.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedWorkType = option.value),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: Colors.white, // ✅ دايماً أبيض، بغض النظر عن الاختيار
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: isSelected ? _navy : _greyBorder, // ✅ بس البوردر بيتغير
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                      color: isSelected ? _navy : _greyBorder, // ✅ بس الدائرة بتتلون
                                      size: 18.w,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      option.label,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                        color: isSelected ? _navy : _greyText, // ✅ النص كحلي عند الاختيار، رمادي غير مختار
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('الساعات المتاحة أسبوعياً',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy)),
                        ),
                        SizedBox(height: 10.h),
                        ChoiceChipGroup(
                          options: _hoursOptions,
                          selectedValues: _selectedHours != null ? [_selectedHours!] : [],
                          onToggle: (value) => setState(() => _selectedHours = value),
                        ),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('الأيام المتاحة للتدريب',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy)),
                        ),
                        SizedBox(height: 10.h),
                        ChoiceChipGroup(
                          options: _daysOptions,
                          selectedValues: _selectedDays,
                          isMultiSelect: true,
                          onToggle: (value) => setState(() {
                            if (_selectedDays.contains(value)) {
                              _selectedDays.remove(value);
                            } else {
                              _selectedDays.add(value);
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: _canSubmit ? _handleFinish : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _navy,
                        disabledBackgroundColor: const Color(0xFFCBD5E0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                      ),
                      child: Text('انهاء واكمال الملف الشخصي',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}