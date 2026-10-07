import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/register_screen.dart';

class Onboarding3Screen extends StatelessWidget {
  final PageController? pageController;

  const Onboarding3Screen({super.key, this.pageController});

  void _finishOnboarding(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. قسم الصورة (متجاوب ومرن بدون مط)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Center(
                  child: Image.asset(
                    'assets/images/onboarding3.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // 2. المحتوى والتفاصيل السفلية
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // العنوان الرئيسي
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'انطلق نحو فرصتك الحقيقية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF011751),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // الوصف الفرعي
                  Text(
                    'ابنِ سيرتك الذاتية وتواصل مباشرة مع الشركات التي تبحث عن مهاراتك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      fontFamily: 'SF Pro',
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // مؤشر الصفحات
                  _buildDynamicIndicators(),
                  SizedBox(height: 36.h),

                  // 3. زر البدء الآن
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: () => _finishOnboarding(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF011751),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'ابدأ الآن',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicIndicators() {
    return AnimatedBuilder(
      animation: pageController ?? PageController(),
      builder: (context, child) {
        int currentPage = 2;
        if (pageController != null && pageController!.hasClients) {
          currentPage = pageController!.page?.round() ?? 2;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            bool isActive = (currentPage == (2 - index));

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 6.h,
              width: isActive ? 22.w : 14.w,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF011751)
                    : const Color(0xFFFFE897),
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          }),
        );
      },
    );
  }
}