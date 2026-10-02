import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/choice_chip_group.dart';

class AvailabilityBottomSheet extends StatefulWidget {
  const AvailabilityBottomSheet({super.key});

  @override
  State<AvailabilityBottomSheet> createState() => _AvailabilityBottomSheetState();
}

class _AvailabilityBottomSheetState extends State<AvailabilityBottomSheet> {
  static const Color _navy = Color(0xFF011751);

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
    // ⚠️ TODO: هون نرسل PUT /student/availability عبر الكيوبت
    // context.read<StudentProfileCubit>().updateAvailability(
    //   workType: _selectedWorkType!, hours: _selectedHours!, days: _selectedDays,
    // );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
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
                  color: const Color(0xFFE2E8F0),
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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close, color: Color(0xFFA0AEC0)),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'الجاهزية وأوقات التوفر',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('طبيعة العمل المفضلة',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy)),
                      ),
                      SizedBox(height: 10.h),
                      ChoiceChipGroup(
                        options: _workTypeOptions,
                        selectedValues: _selectedWorkType != null ? [_selectedWorkType!] : [],
                        onToggle: (value) => setState(() => _selectedWorkType = value),
                      ),
                      SizedBox(height: 20.h),

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
                    child: Text(
                      'إنهاء واكمال الملف الشخصي',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}