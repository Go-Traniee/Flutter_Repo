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
      body: Stack(
        children: [
          // 1. الصورة العلوية
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 660.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Onboarding screen1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 180.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. المحتوى والتفاصيل السفليّة
          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                // النصوص الأساسية
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w), // زيادة المساحة الجانبية للنص لتستوعب السطر
                  child: Column(
                    children: [
                      // تم استخدام FittedBox لضمان بقاء السطر الأول كاملاً على سطر واحد دون نزول أي كلمة
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
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // مؤشر الصفحات
                _buildDynamicIndicators(),

                SizedBox(height: 36.h),

                // 3. الأزرار السفليّة (تمت زيادة الـ Padding لتكبير المسافة من الحواف السفلية والجانبية)
                Padding(
                  padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // كلمة تخطي
                      InkWell(
                        onTap: () => _skipAll(context),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
            bool isActive = (currentPage == (2 - index));

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 6.h,
              width: isActive ? 22.w : 14.w,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF011751) : const Color(0xFFFFE897),
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          }),
        );
      },
    );
  }
}