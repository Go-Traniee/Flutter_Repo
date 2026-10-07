// availability_repository_impl.dart
import 'package:dio/dio.dart';
import '../../domain/repositories/availability_repository.dart';
import '../models/availability_request_model.dart';

class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final Dio dio;
  AvailabilityRepositoryImpl(this.dio);

  @override
  Future<void> updateAvailability(AvailabilityRequestModel request) async {
    try {
      await dio.put('student/availability', data: request.toJson());
    } on DioException catch (e) {
      final msg = e.response?.data is Map ? e.response?.data['message'] : null;
      throw Exception(msg ?? 'حدث خطأ أثناء حفظ الجاهزية');
    }
  }
}