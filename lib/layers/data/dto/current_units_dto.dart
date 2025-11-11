import 'package:weather/layers/domain/entity/current_units_entity.dart';

// ignore: must_be_immutable
class CurrentWeatherUnitsDto extends CurrentWeatherUnitsEntity {
  CurrentWeatherUnitsDto({
    super.time,
    super.interval,
    super.temperature2m,
    super.relativeHumidity2m,
    super.isDay,
    super.weatherCode,
    super.windSpeed10m,
    super.windDirection10m,
  });
  factory CurrentWeatherUnitsDto.fromMap(Map<String, dynamic> json) =>
      CurrentWeatherUnitsDto(
        time: json['time'],
        interval: json['interval'],
        temperature2m: json['temperature_2m'],
        relativeHumidity2m: json['relative_humidity_2m'],
        isDay: json['is_day'],
        weatherCode: json['weather_code'],
        windSpeed10m: json['wind_speed_10m'],
        windDirection10m: json['wind_direction_10m'],
      );

  Map<String, dynamic> toMap() => {
        'time': time,
        'interval': interval,
        'temperature_2m': temperature2m,
        'relative_humidity_2m': relativeHumidity2m,
        'is_day': isDay,
        'weather_code': weatherCode,
        'wind_speed_10m': windSpeed10m,
        'wind_direction_10m': windDirection10m,
      };
}
