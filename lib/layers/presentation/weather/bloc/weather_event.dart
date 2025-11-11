part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class FetchWeatherEvent extends WeatherEvent {
  // final double latitude;
  // final double longitude;
  // const FetchWeatherEvent({required this.latitude, required this.longitude});
  const FetchWeatherEvent();
  // @override
  // List<Object> get props => [latitude, longitude];
}
