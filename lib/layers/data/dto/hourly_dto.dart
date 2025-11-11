import 'package:weather/layers/domain/entity/hourly_entity.dart';

// ignore: must_be_immutable
class HourlyDto extends HourlyEntity {
  HourlyDto(
      {super.time,
      super.temperature2m,
      super.relativeHumidity2m,
      super.precipitationProbability,
      super.weatherCode,
      super.windSpeed10m,
      super.windDirection10m});
  factory HourlyDto.fromMap(Map<String, dynamic> json) => HourlyDto(
        time: json['time'] == null
            ? []
            : List<String>.from(json['time']!.map((x) => x)),
        temperature2m: json['temperature_2m'] == null
            ? []
            : List<double>.from(json['temperature_2m']!.map((x) => x)),
        relativeHumidity2m: json['relativeHumidity2m'] == null
            ? []
            : List<double>.from(json['relativeHumidity2m']!.map((x) => x)),
        precipitationProbability: json['precipitationProbability'] == null
            ? []
            : List<double>.from(
                json['precipitationProbability']!.map((x) => x)),
        weatherCode: json['weather_code'] == null
            ? []
            : List<int>.from(json['weather_code']!.map((x) => x)),
        windSpeed10m: json['windSpeed10m'] == null
            ? []
            : List<double>.from(json['windSpeed10m']!.map((x) => x)),
        windDirection10m: json['windDirection10m'] == null
            ? []
            : List<double>.from(json['windDirection10m']!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'time': this.time,
        'temperature_2m': this.temperature2m,
        'relative_humidity_2m': this.relativeHumidity2m,
        'precipitationProbability': this.precipitationProbability,
        'weather_code': this.weatherCode,
        'wind_speed_10m': this.windSpeed10m,
        'wind_direction_10m': this.windDirection10m,
      };
}
