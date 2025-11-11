import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CurrentWeatherEntity with EquatableMixin {
  String? time;
  int? interval;
  double? temperature2m;
  int? relativeHumidity2m;
  int? isDay;
  int? weatherCode;
  double? windSpeed10m;
  int? windDirection10m;
  CurrentWeatherEntity(
      {this.time,
      this.interval,
      this.temperature2m,
      this.relativeHumidity2m,
      this.isDay,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  @override
  List<Object?> get props => [
        time,
        interval,
        temperature2m,
        relativeHumidity2m,
        isDay,
        weatherCode,
        windSpeed10m,
        windDirection10m
      ];
}
