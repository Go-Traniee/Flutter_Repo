
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/widgets/small_action.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_cubit.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_state.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/buildDropdownField.dart';
import 'package:gotraniee_flutter/features/student/data/models/skill_model.dart';

class AddSkillBottomSheet extends StatefulWidget {
  final VoidCallback onContinue;
  const AddSkillBottomSheet({super.key, required this.onContinue});

  @override
  State<AddSkillBottomSheet> createState() => _AddSkillBottomSheetState();
}

class _AddSkillBottomSheetState extends State<AddSkillBottomSheet> {
  static const Color _navy = Color(0xFF011751);
  static const Color _greyText = Color(0xFFA0AEC0);
  static const Color _red = Color(0xFFE53E3E);

  @override
  void initState() {
    super.initState();
    context.read<StudentSkillCubit>().loadSkills();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentSkillCubit>().state;
    final bool isLoading = state is StudentSkillLoading || state is StudentSkillInitial;

    final List<SkillModel> availableSkills =
    state is StudentSkillLoaded ? state.availableSkills : _placeholderSkills;
    final topSuggestions = availableSkills.take(6).toList();
    final addedSkills = state is StudentSkillLoaded ? state.addedSkills : [];
    final selectedSkill = state is StudentSkillLoaded ? state.selectedSkill : null;
    final bool hasSkills = addedSkills.isNotEmpty;

    return DraggableScrollableSheet(
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
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: Skeletonizer(
                  enabled: isLoading,
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
                              child: const Icon(Icons.close, color: _greyText),
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        // ✅ حذفنا كلمة "ومستوى الإتقان" من العنوان
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'إضافة المهارات',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        // ✅ حذفنا إشارة الإتقان من النص الفرعي كمان
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'حدد مهاراتك الرئيسية لتسهيل المطابقة مع التدريبات',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12.sp, color: _navy),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'اسم المهارة:',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            SmallActionButton(
                              text: 'إضافة مهارة',
                              icon: Icons.add,
                              onPressed: (selectedSkill == null || isLoading)
                                  ? null
                                  : () => context.read<StudentSkillCubit>().addSelectedSkill(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomDropdownField(
                                hintText: '',
                                iconPath: '',
                                fallbackIcon: Icons.search,
                                value: selectedSkill?.name,
                                items: availableSkills.map((s) => s.name).toList(),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (val) {
                                  if (val == null) return;
                                  final skill = availableSkills.firstWhere((s) => s.name == val);
                                  context.read<StudentSkillCubit>().selectSkill(skill);
                                },
                                validator: (val) => null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('اقتراح:', style: TextStyle(fontSize: 12.sp, color: _greyText)),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: topSuggestions.map((skill) {
                            final isSelected = selectedSkill?.id == skill.id;
                            return GestureDetector(
                              onTap: () => context.read<StudentSkillCubit>().selectSkill(skill),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: isSelected ? _navy : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  skill.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isSelected ? Colors.white : _navy,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24.h),

                        if (!hasSkills)
                          _buildEmptyState()
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addedSkills.length,
                            itemBuilder: (context, index) {
                              final studentSkill = addedSkills[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          studentSkill.skill.name,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: _navy,
                                          ),
                                        ),
                                      ),
                                      // ✅ حذفنا زر "تعديل" بالكامل، بقي "حذف" بس
                                      GestureDetector(
                                        onTap: () => context
                                            .read<StudentSkillCubit>()
                                            .deleteSkill(studentSkill.id),
                                        child: Text('حذف', style: TextStyle(fontSize: 12.sp, color: _red)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (hasSkills)
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // ⚠️ TODO: المهارات أصلاً اتحفظت فوراً وقت الإضافة (POST /student/skills)
                        // فما في داعي نرسل شي إضافي هون، بس ننتقل للبوب التالي
                        Navigator.pop(context);
                        widget.onContinue();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _navy,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                      ),
                      child: Text(
                        'متابعة',
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/addSkill.png',
          height: 140.h,
          errorBuilder: (_, __, ___) => Icon(Icons.extension_outlined, size: 80.w, color: _greyText),
        ),
        SizedBox(height: 16.h),
        Text('لم تقم بإضافة أي مهارات بعد',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy)),
        SizedBox(height: 6.h),
        Text(
          'أضف مهاراتك ليتم تحديد مستواك\nومطابقتك مع الفرص والتدريبات المناسبة!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp, color: _greyText, height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  static final List<SkillModel> _placeholderSkills = List.generate(
    6, (i) => SkillModel(id: i, name: '████████'),
  );
}



/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/widgets/small_action.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_cubit.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_state.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/buildDropdownField.dart';
import 'package:gotraniee_flutter/features/student/data/models/skill_model.dart';

class AddSkillBottomSheet extends StatefulWidget {
  final VoidCallback onContinue;
  const AddSkillBottomSheet({super.key, required this.onContinue});

  @override
  State<AddSkillBottomSheet> createState() => _AddSkillBottomSheetState();
}

class _AddSkillBottomSheetState extends State<AddSkillBottomSheet> {
  static const Color _navy = Color(0xFF011751);
  static const Color _greyText = Color(0xFFA0AEC0);
  static const Color _red = Color(0xFFE53E3E);

  @override
  void initState() {
    super.initState();
    // ✅ نطلب تحميل المهارات فور فتح البوب
    context.read<StudentSkillCubit>().loadSkills();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ context.watch هون لأننا جوا build، وبدنا الويدجت يعيد نفسه تلقائياً كل تغيير حالة
    final state = context.watch<StudentSkillCubit>().state;
    final bool isLoading = state is StudentSkillLoading || state is StudentSkillInitial;

    final List<SkillModel> availableSkills =
    state is StudentSkillLoaded ? state.availableSkills : _placeholderSkills;
    final List topSuggestions = availableSkills.take(6).toList();
    final addedSkills = state is StudentSkillLoaded ? state.addedSkills : [];
    final selectedSkill = state is StudentSkillLoaded ? state.selectedSkill : null;
    final bool hasSkills = addedSkills.isNotEmpty;

    return DraggableScrollableSheet(
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
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: Skeletonizer(
                  enabled: isLoading,
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
                              child: const Icon(Icons.close, color: _greyText),
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'إضافة المهارات ومستوى الإتقان',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'حدد مهاراتك الرئيسية ومستوى إتقانك لتسهيل المطابقة مع التدريبات',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12.sp, color: _navy),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'اسم المهارة:',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: _navy),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            SmallActionButton(
                              text: 'إضافة مهارة',
                              icon: Icons.add,
                              onPressed: (selectedSkill == null || isLoading)
                                  ? null
                              // ✅ context.read جوا onPressed لأنه فعل (Action) لمرة وحدة
                                  : () => context.read<StudentSkillCubit>().addSelectedSkill(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomDropdownField(
                                hintText: '',
                                iconPath: '',
                                fallbackIcon: Icons.search,
                                value: selectedSkill?.name,
                                items: availableSkills.map((s) => s.name).toList(),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (val) {
                                  if (val == null) return;
                                  final skill = availableSkills.firstWhere((s) => s.name == val);
                                  context.read<StudentSkillCubit>().selectSkill(skill);
                                },
                                validator: (val) => null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('اقتراح:', style: TextStyle(fontSize: 12.sp, color: _greyText)),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 8.w,
                          runSpacing: 8.h,
                          // ✅ أشهر 6 مهارات بس كـ chips، مش القائمة كاملة (أداء أفضل لقائمة طويلة)
                          children: topSuggestions.map((skill) {
                            final isSelected = selectedSkill?.id == skill.id;
                            return GestureDetector(
                              onTap: () => context.read<StudentSkillCubit>().selectSkill(skill),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: isSelected ? _navy : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  skill.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isSelected ? Colors.white : _navy,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24.h),

                        if (!hasSkills)
                          _buildEmptyState()
                        else
                        // ✅ ListView.builder بدل Column عادي: أداء أفضل لو القائمة كبرت مستقبلاً
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addedSkills.length,
                            itemBuilder: (context, index) {
                              final studentSkill = addedSkills[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          studentSkill.skill.name,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: _navy,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // TODO: فتح بوب تعديل مستوى الإتقان
                                        },
                                        child: Text('تعديل', style: TextStyle(fontSize: 12.sp, color: _navy)),
                                      ),
                                      SizedBox(width: 12.w),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<StudentSkillCubit>()
                                            .deleteSkill(studentSkill.id),
                                        child: Text('حذف', style: TextStyle(fontSize: 12.sp, color: _red)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (hasSkills)
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onContinue(); // ✅ ينادي الأب لفتح بوب الجاهزية
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _navy,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                      ),
                      child: Text(
                        'متابعة',
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/addSkill.png',
          height: 140.h,
          errorBuilder: (_, __, ___) => Icon(Icons.extension_outlined, size: 80.w, color: _greyText),
        ),
        SizedBox(height: 16.h),
        Text('لم تقم بإضافة أي مهارات بعد',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: _navy)),
        SizedBox(height: 6.h),
        Text(
          'أضف مهاراتك ليتم تحديد مستواك\nومطابقتك مع الفرص والتدريبات المناسبة!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp, color: _greyText, height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // بيانات وهمية بس وقت التحميل (Skeleton)، ما بتظهر للمستخدم فعلياً
  static final List<SkillModel> _placeholderSkills = List.generate(
    6,
        (i) => SkillModel(id: i, name: '████████'),
  );
}*/