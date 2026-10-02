import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/features/auth/presentation/screens/register_screen.dart';

class Onboarding3Screen extends StatelessWidget {
  final PageController? pageController;

  const Onboarding3Screen({super.key, this.pageController});

  void _finishOnboarding(BuildContext context) {
    // هنا يتم الانتقال للشاشة التالية في التطبيق (مثلاً شاشة تسجيل الدخول)

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  RegisterScreen()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. الصورة والتدرج العلوي
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 660.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Onboarding screen1.png', // استبدلي الصورة بمسار الصورة الثالثة
                    fit: BoxFit.cover,),),
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
                          Colors.white,],),),),),],),),

          // 2. النصوص والتفاصيل
          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                // النصوص الأساسية
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'انطلق نحو فرصتك الحقيقية',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF011751),),),),
                      SizedBox(height: 10.h),
                      Text(
                        'ابنِ سيرتك الذاتية وتواصل مباشرة مع الشركات التي تبحث عن مهاراتك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black87,
                          fontFamily: 'SF Pro',
                          height: 1.4,),),],),),
                SizedBox(height: 24.h),

                // مؤشر الصفحات (الشريط الكحلي على اليسار دائماً)
                _buildIndicators(),

                SizedBox(height: 36.h),

                // 3. زر البدء
                Padding(
                  padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 24.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () => _finishOnboarding(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF011751),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),),
                        elevation: 0,),
                      child: Text(
                        'ابدأ الآن',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,),),),),),],),),],),);}

  // بناء مؤشر الصفحات المباشر لمنع أي لخبطة بالاتجاهات
  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIndicator(isActive: true),
        SizedBox(width: 6.w),
// أصفر (يمين)
        _buildIndicator(isActive: false), // أصفر (وسط)
        SizedBox(width: 6.w),
        _buildIndicator(isActive: false),
        SizedBox(width: 6.w),
// كحلي (يسار)
      ],
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 6.h,
      width: isActive ? 22.w : 14.w,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF011751) : const Color(0xFFFFE897),
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }
}

