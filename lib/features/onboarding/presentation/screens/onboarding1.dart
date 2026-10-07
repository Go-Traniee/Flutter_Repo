import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/Onboarding2Screen.dart';

class Onboarding1Screen extends StatelessWidget {
  final PageController? pageController;

  const Onboarding1Screen({super.key, this.pageController});

  void _goToNext(BuildContext context) {
    if (pageController != null && pageController!.hasClients) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Onboarding2Screen(),
        ),
      );
    }
  }

  void _skipAll(BuildContext context) {
    if (pageController != null && pageController!.hasClients) {
      pageController!.animateToPage(
        2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Onboarding2Screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. قسم الصورة (متجاوب ومرن مع كافة الشاشات بدون مط)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Center(
                  child: Image.asset(
                    'assets/images/onboarding1.png',
                    fit: BoxFit.contain, // إظهار الصورة كاملة كما في فيجما
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
                      'منصتك الذكية للربط بين طموح الطلاب واحتياجات الشركات!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF011751),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // الوصف الفرعي
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        fontFamily: 'SF Pro',
                      ),
                      children: const [
                        TextSpan(text: 'نقيس المهارات، نبني الخبرات، و '),
                        TextSpan(
                          text: 'نوفر الفرص',
                          style: TextStyle(
                            color: Color(0xFFE2A519),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' الحقيقية.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // مؤشر الصفحات
                  _buildDynamicIndicators(),
                  SizedBox(height: 36.h),

                  // 3. الأزرار السفليّة (تخطي والتالي)
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // كلمة تخطي
                        InkWell(
                          onTap: () => _skipAll(context),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            child: Text(
                              'تخطي',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF011751).withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),

                        // كلمة التالي
                        InkWell(
                          onTap: () => _goToNext(context),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            child: Text(
                              'التالي',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF011751),
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
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicIndicators() {
    return AnimatedBuilder(
      animation: pageController ?? PageController(),
      builder: (context, child) {
        int currentPage = 0;
        if (pageController != null && pageController!.hasClients) {
          currentPage = pageController!.page?.round() ?? 0;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // تصحيح الشرط ليكون ترتيب المؤشر مطابقاً للاتجاه العربي (RTL)
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