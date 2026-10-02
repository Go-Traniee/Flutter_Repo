import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotraniee_flutter/features/student/data/datasources/student_skill_remote_datasource.dart';
import 'package:gotraniee_flutter/features/student/data/repositories/student_skill_repository_impl.dart';
import 'package:gotraniee_flutter/features/student/domain/repositories/student_skill_repository.dart';
import 'package:gotraniee_flutter/features/student/domain/usecases/add_skill_usecase.dart';
import 'package:gotraniee_flutter/features/student/domain/usecases/delete_skill_usecase.dart';
import 'package:gotraniee_flutter/features/student/domain/usecases/get_available_skills_usecase.dart';
import 'package:gotraniee_flutter/features/student/presentation/controllers/student_skill_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth Imports
import '../../features/auth/data/repositories/login_repository_impl.dart';
import '../../features/auth/presentation/controllers/login_cubit.dart';

// Google & Onboarding Data Sources & Repositories
import '../../features/onboarding/data/datasources/google_onboarding_remote_datasource.dart';
import '../../features/onboarding/data/repositories/google_onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/google_onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/google_onboarding_usecase.dart';
import '../../features/onboarding/presentation/controllers/google_auth_cubit.dart';
//يبني كل الكائنات مرة وحدة، يوفرها لأي مكان بالتطبيق

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // 1. Dio مع خيارات آمنة
  getIt.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: 'https://your-api-domain.com/api/', //رابط السيرفر
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    ),
  );

  // 2. Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
  );

  // 2.1 Shared Preferences (لحفظ الإيميل عند "تذكرني")
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // 3. Login Repository Impl
  getIt.registerLazySingleton<LoginRepositoryImpl>(
        () => LoginRepositoryImpl(
      dio: getIt(),
      secureStorage: getIt(),
      sharedPreferences: getIt(), //  إضافة
    ),
  );

  // 4. Login Cubit
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<LoginRepositoryImpl>()),
  );

  // 5.1 Remote DataSource
  getIt.registerLazySingleton<GoogleOnboardingRemoteDataSource>(
        () => GoogleOnboardingRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // 5.2 Google Onboarding Repository
  getIt.registerLazySingleton<GoogleOnboardingRepository>(
        () => GoogleOnboardingRepositoryImpl(
      remoteDataSource: getIt<GoogleOnboardingRemoteDataSource>(),
    ),
  );

  // 6. Google Onboarding UseCase
  getIt.registerLazySingleton<GoogleOnboardingUseCase>(
        () => GoogleOnboardingUseCase(repository: getIt<GoogleOnboardingRepository>()),
  );

  // 7. Google Auth Cubit
  getIt.registerFactory<GoogleAuthCubit>(
        () => GoogleAuthCubit(getIt<GoogleOnboardingUseCase>()),
  );
  getIt.registerLazySingleton<StudentSkillRemoteDataSource>(
        () => StudentSkillRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<StudentSkillRepository>(
        () => StudentSkillRepositoryImpl(getIt<StudentSkillRemoteDataSource>()),
  );
  getIt.registerFactory<StudentSkillCubit>(
        () => StudentSkillCubit(
      getAvailableSkillsUseCase: GetAvailableSkillsUseCase(getIt<StudentSkillRepository>()),
      addSkillUseCase: AddSkillUseCase(getIt<StudentSkillRepository>()),
      deleteSkillUseCase: DeleteSkillUseCase(getIt<StudentSkillRepository>()),
    ),
  );
}











/*import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Auth Imports
import '../../features/auth/data/repositories/login_repository_impl.dart';
import '../../features/auth/presentation/controllers/login_cubit.dart';

// Google & Onboarding Data Sources & Repositories
import '../../features/onboarding/data/datasources/google_onboarding_remote_datasource.dart';
import '../../features/onboarding/data/repositories/google_onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/google_onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/google_onboarding_usecase.dart';
import '../../features/onboarding/presentation/controllers/google_auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // 1. Dio مع خيارات آمنة
  getIt.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: 'https://your-api-domain.com/api/',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    ),
  );

  // 2. Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
  );

  // 3. Login Repository Impl
  getIt.registerLazySingleton<LoginRepositoryImpl>(
        () => LoginRepositoryImpl(
      dio: getIt(),
      secureStorage: getIt(),
    ),
  );

  // 4. Login Cubit
  getIt.registerFactory<LoginCubit>(
        () => LoginCubit(getIt<LoginRepositoryImpl>()),
  );

  // 5.1 Remote DataSource (تسجيل الـ Remote DataSource وتمرير Dio له)
  getIt.registerLazySingleton<GoogleOnboardingRemoteDataSource>(
        () => GoogleOnboardingRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // 5.2 Google Onboarding Repository (تمرير remoteDataSource بالاسم المطلوب)
  getIt.registerLazySingleton<GoogleOnboardingRepository>(
        () => GoogleOnboardingRepositoryImpl(
      remoteDataSource: getIt<GoogleOnboardingRemoteDataSource>(),
    ),
  );

  // 6. Google Onboarding UseCase
  getIt.registerLazySingleton<GoogleOnboardingUseCase>(
        () => GoogleOnboardingUseCase(repository: getIt<GoogleOnboardingRepository>()),
  );

  // 7. Google Auth Cubit
  getIt.registerFactory<GoogleAuthCubit>(
        () => GoogleAuthCubit(getIt<GoogleOnboardingUseCase>()),
  );
}*/