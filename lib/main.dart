import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotraniee_flutter/core/network/service_locator.dart';
import 'package:gotraniee_flutter/features/onboarding/presentation/screens/splash.dart';
import 'package:gotraniee_flutter/features/student/presentation/screens/AcademicDataScreen.dart';

void main() async {
  // 1. تأكيد تهيئة محرك فلاتر قبل أي شيء
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تشغيل الـ Service Locator لتجهيز الحقن (GetIt)
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // أبعاد الشاشة القياسية للتصميم
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoTrainer',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: child,
        );
      },//SplashScreen
      child: const SplashScreen(),
    );
  }
}
//const SplashScreen(),