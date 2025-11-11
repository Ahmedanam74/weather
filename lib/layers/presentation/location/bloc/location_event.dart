part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

final class GetLocationEvent extends LocationEvent {
  const GetLocationEvent();
}
final class CheckConnectionEvent extends LocationEvent {
  const CheckConnectionEvent();
}
final class CheckInitialConnection extends LocationEvent {
  const CheckInitialConnection();
}
