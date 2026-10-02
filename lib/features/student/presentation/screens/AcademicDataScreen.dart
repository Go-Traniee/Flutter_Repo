import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/network/service_locator.dart';
import 'package:gotraniee_flutter/core/widgets/primary_button.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_cubit.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/add_skill_bottom_sheet.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/availability_bottom_sheet.dart';
import 'package:gotraniee_flutter/features/student/presentation/widgets/buildDropdownField.dart';

class AcademicDataScreen extends StatefulWidget {
  const AcademicDataScreen({super.key});

  @override
  State<AcademicDataScreen> createState() => _AcademicDataScreenState();
}

class _AcademicDataScreenState extends State<AcademicDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  String? _selectedUniversity;
  String? _selectedAcademicStatus;
  String? _selectedMajor;
  String? _selectedSpecialization;
  String? _selectedGraduationYear;

  final List<String> _universities = [
    'الجامعة الإسلامية',
    'جامعة الأزهر',
    'جامعة الأقصى',
    'جامعة فلسطين',
    'جامعة القدس المفتوحة',
    'الكلية الجامعية للعلوم التطبيقية',
    'أخرى',];
  final List<String> _academicStatuses = [
    'طالب',
    'خريج',
  ];
  final List<String> _majors = [
    'هندسة الحاسوب',
    'علوم الحاسوب',
    'نظم المعلومات',
    'هندسة البرمجيات',
    'هندسة حاسوب واتصالات',
    'إدارة الأعمال',
    'المحاسبة والتمويل',
    'الهندسة الكهربائية',
    'تطوير الويب',
    'تطوير تطبيقات الجوال',
    'الذكاء الاصطناعي وعلوم البيانات',
    'أمن المعلومات',
    'الشبكات',
    'الأمن السيبراني',
    'أخرى',
  ];
  final List<String> _specializations = [
    'تطوير الواجهات الأمامية (Frontend)',
    'تطوير الواجهات الخلفية (Backend)',
    'تطوير تطبيقات الجوال',
    'الذكاء الاصطناعي',
    'أمن المعلومات',
    'إدارة قواعد البيانات',
    'أخرى',
  ];
  final List<String> _graduationYears = [
    '2020', '2021', '2022', '2023', '2024', '2025',
    '2026', '2027', '2028', '2029', '2030', '2031',
    '2032', '2033', '2034', '2035',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();}



  /*void _handleNext() {
    if (_formKey.currentState!.validate()) {
      // TODO: بناء AcademicDataRequestModel وإرسالها عبر الكيوبت
      // الانتقال لفتح Popup إضافة المهارات
    }
  }*/
  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      _showAddSkillPopup(context);}}

  void _showAddSkillPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (popupContext) => BlocProvider(
        create: (_) => getIt<StudentSkillCubit>(), // ✅ من service_locator، زي ما اتفقنا بالريجستر
        child: AddSkillBottomSheet(
          onContinue: () => _showAvailabilityPopup(context), // ✅ الربط بين البوبين
        ),
      ),
    );
  }

  void _showAvailabilityPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (popupContext) => const AvailabilityBottomSheet(),
    );
  }  @override
  Widget build(BuildContext context) {
    final isPhoneValid = _phoneController.text.trim().length == 9;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10.h),

                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset('assets/images/goTrainee.png',
                      height: 63.h, fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.school, size: 40.w,
                        color: const Color(0xFF011751),),),),

                  Center(child: Text(
                      'أكمل ملفك الشخصي',
                      style: TextStyle(fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF011751),),),),
                  SizedBox(height: 24.h),

                  Align(
                    alignment: Alignment.centerRight, child: Text(
                      'البيانات الأكاديمية',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold,
                        color: const Color(0xFF011751),),),),
                  SizedBox(height: 16.h),

                  // أ. اسم الجامعة
                  CustomDropdownField(
                    hintText: 'اسم الجامعة',
                    iconPath: 'assets/icons/Academic.png',
                    fallbackIcon: Icons.account_balance_outlined,
                    value: _selectedUniversity,
                    items: _universities,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() => _selectedUniversity = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'يرجى اختيار اسم الجامعة' : null,
                  ),
                  SizedBox(height: 12.h),

                  // ب. الحالة الأكاديمية
                  CustomDropdownField(
                    hintText: 'الحالة الأكاديمية',
                    iconPath: 'assets/icons/academic_hat.png',
                    fallbackIcon: Icons.school_outlined,
                    value: _selectedAcademicStatus,
                    items: _academicStatuses,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() => _selectedAcademicStatus = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'يرجى اختيار الحالة الأكاديمية' : null,
                  ),
                  SizedBox(height: 12.h),

                  // ج. التخصص الجامعي
                  CustomDropdownField(
                    hintText: 'التخصص الجامعي',
                    iconPath: 'assets/icons/academic_hat.png',
                    fallbackIcon: Icons.school_outlined,
                    value: _selectedMajor,
                    items: _majors,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() => _selectedMajor = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'يرجى اختيار التخصص الجامعي' : null,
                  ),
                  SizedBox(height: 12.h),

                  // ✅ جديد: د. التخصص الفرعي (specialization)
                  CustomDropdownField(
                    hintText: 'التخصص الفرعي',
                    iconPath: 'assets/icons/academic_hat.png',
                    fallbackIcon: Icons.school_outlined,
                    value: _selectedSpecialization,
                    items: _specializations,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() => _selectedSpecialization = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'يرجى اختيار التخصص الفرعي' : null,
                  ),
                  SizedBox(height: 12.h),

                  // هـ. سنة التخرج / المتوقعة
                  CustomDropdownField(
                    hintText: 'سنة التخرج / المتوقعة',
                    iconPath: 'assets/icons/calendar.png',
                    fallbackIcon: Icons.calendar_today_outlined,
                    value: _selectedGraduationYear,
                    items: _graduationYears,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() => _selectedGraduationYear = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'يرجى اختيار سنة التخرج' : null,
                  ),
                  SizedBox(height: 12.h),

                  // رقم الهاتف المحمول
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    onChanged: (val) {
                      setState(() {});
                    },
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'يرجى إدخال رقم الهاتف';
                      }
                      if (val.trim().length < 9) {
                        return 'يجب إدخال 9 أرقام كاملة';
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 13.sp, color: const Color(0xFF2D3748)),
                    decoration: InputDecoration(
                      hintText: 'رقم الهاتف المحمول',
                      hintStyle: TextStyle(fontSize: 13.sp, color: const Color(0xFFA0AEC0)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Image.asset(
                          'assets/icons/phone.png',
                          width: 20.w,
                          height: 20.h,
                          color: isPhoneValid ? Colors.green : null,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.smartphone_outlined,
                            size: 20.w,
                            color: isPhoneValid ? Colors.green : const Color(0xFFA0AEC0),
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: isPhoneValid ? Colors.green : const Color(0xFFE2E8F0),
                          width: isPhoneValid ? 1.5 : 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: isPhoneValid ? Colors.green : const Color(0xFF011751),
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
                  ),
                  SizedBox(height: 48.h),

                  PrimaryButton(
                    text: 'التالي',
                    onPressed: _handleNext,
                  ),],),),),),),);}}
