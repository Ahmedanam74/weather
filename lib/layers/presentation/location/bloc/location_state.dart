part of 'location_bloc.dart';

enum LocationStatus { initial, loading, loaded, error }

enum ConnectionStatus { initial, loading, connected, disconnected }

class LocationState extends Equatable {
  const LocationState(
      {this.status = LocationStatus.initial,
      this.connectionStatus = ConnectionStatus.initial,
      this.result=const[],
      this.errorMessege = "",
      this.latitude = 0,
      this.longitude = 0});
  final LocationStatus status;
  final ConnectionStatus connectionStatus;
  final String errorMessege;
  final List<ConnectivityResult> result;
  final double latitude;
  final double longitude;
  LocationState copyWith(
      {LocationStatus? status,
      ConnectionStatus? connectionStatus,
      List<ConnectivityResult>? result,
      String? errorMessege,
      double? latitude,
      double? longitude,}) {
    return LocationState(
        status: status ?? this.status,
        connectionStatus: connectionStatus ?? this.connectionStatus,
        result: result ?? this.result,
        errorMessege: errorMessege ?? this.errorMessege,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  @override
  List<Object> get props =>
      [status, connectionStatus,result, errorMessege, latitude, longitude];
}
