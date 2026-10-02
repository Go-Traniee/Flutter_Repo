import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/google_onboarding_repository.dart';
import '../datasources/google_onboarding_remote_datasource.dart';
import '../models/google_auth_request_model.dart';
import '../models/google_auth_response_model.dart';
import '../models/google_onboarding_request_model.dart';

class GoogleOnboardingRepositoryImpl implements GoogleOnboardingRepository {
  final GoogleOnboardingRemoteDataSource remoteDataSource;

  GoogleOnboardingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, GoogleAuthResponseModel>> googleAuth(GoogleAuthRequestModel request) async {
    try {
      final response = await remoteDataSource.googleAuth(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ أثناء المصادقة عبر Google');
    } catch (e) {
      return Left('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> completeOnboarding(GoogleOnboardingRequestModel request) async {
    try {
      final result = await remoteDataSource.completeOnboarding(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ أثناء إكمال البيانات');
    } catch (e) {
      return Left('حدث خطأ غير متوقع: $e');
    }
  }
}