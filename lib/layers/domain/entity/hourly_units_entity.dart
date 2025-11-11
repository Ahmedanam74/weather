import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class HourlyUnitsEntity with EquatableMixin {
  String? time;
  String? temperature2m;
  String? relativeHumidity2m;
  String? precipitationProbability;
  String? weatherCode;
  String? windSpeed10m;
  String? windDirection10m;

  HourlyUnitsEntity(
      {this.time,
      this.temperature2m,
      this.relativeHumidity2m,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});

  @override
  // TODO: implement props
  List<Object?> get props => [
        time,
        temperature2m,
        relativeHumidity2m,
        precipitationProbability,
        weatherCode,
        windSpeed10m,
        windDirection10m
      ];
}
