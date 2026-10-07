// availability_repository.dart (domain)
import '../../data/models/availability_request_model.dart';

abstract class AvailabilityRepository {
  Future<void> updateAvailability(AvailabilityRequestModel request);
}