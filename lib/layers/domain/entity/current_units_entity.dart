import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CurrentWeatherUnitsEntity with EquatableMixin{
 String? time;
  String? interval;
  String? temperature2m;
  String? relativeHumidity2m;
  String? isDay;
  String? weatherCode;
  String? windSpeed10m;
  String? windDirection10m;
  CurrentWeatherUnitsEntity(
      {this.time,
      this.interval,
      this.temperature2m,
      this.relativeHumidity2m,
      this.isDay,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m,});
      
        @override
        // TODO: implement props
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
