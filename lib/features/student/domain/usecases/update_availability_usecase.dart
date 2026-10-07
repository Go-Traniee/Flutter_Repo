// update_availability_usecase.dart
import '../repositories/availability_repository.dart';
import '../../data/models/availability_request_model.dart';

class UpdateAvailabilityUseCase {
  final AvailabilityRepository repository;
  UpdateAvailabilityUseCase(this.repository);

  Future<void> call(AvailabilityRequestModel request) =>
      repository.updateAvailability(request);
}