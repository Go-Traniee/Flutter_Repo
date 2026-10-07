// availability_state.dart
abstract class AvailabilityState {}
class AvailabilityInitial extends AvailabilityState {}
class AvailabilityLoading extends AvailabilityState {}
class AvailabilitySaved extends AvailabilityState {}
class AvailabilityError extends AvailabilityState {
  final String message;
  AvailabilityError(this.message);
}