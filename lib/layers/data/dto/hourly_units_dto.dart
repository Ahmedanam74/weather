import 'package:weather/layers/domain/entity/hourly_units_entity.dart';

// ignore: must_be_immutable
class HourlyUnitsDto extends HourlyUnitsEntity {
  HourlyUnitsDto(
      {super.time,
      super.temperature2m,
      super.relativeHumidity2m,
      super.precipitationProbability,
      super.weatherCode,
      super.windSpeed10m,
      super.windDirection10m});
  factory HourlyUnitsDto.fromMap(Map<String, dynamic> json) => HourlyUnitsDto(
        time: json['time'],
        temperature2m: json['temperature_2m'],
        relativeHumidity2m: json['relative_humidity_2m'],
        precipitationProbability: json['precipitationProbability'],
        weatherCode: json['weather_code'],
        windSpeed10m: json['wind_speed_10m'],
        windDirection10m: json['wind_direction_10m'],
      );

  Map<String, dynamic> toMap() => {
        'time': time,
        'temperature_2m': temperature2m,
        'relative_humidity_2m': relativeHumidity2m,
        'precipitationProbability': precipitationProbability,
        'weather_code': weatherCode,
        'wind_speed_10m': windSpeed10m,
        'wind_direction_10m': windDirection10m,
      };
}
