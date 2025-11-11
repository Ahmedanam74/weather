part of 'weather_bloc.dart';

enum WeatherPageStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState(
      {this.status = WeatherPageStatus.initial, this.weather = const [],this.cityName=""});
  final WeatherPageStatus status;
  final List<WeatherEentity> weather;
  final String cityName ;
  WeatherState copyWith(
      {WeatherPageStatus? status, List<WeatherEentity>? weather,String ?cityName}) {
    return WeatherState(
        status: status ?? this.status,
        weather: weather ?? this.weather,
        cityName: cityName ?? this.cityName,
        );
  }

  @override
  List<Object> get props => [status, weather,cityName];
}
