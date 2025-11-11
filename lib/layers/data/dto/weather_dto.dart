import 'dart:convert';

import 'package:weather/layers/data/dto/current_dto.dart';
import 'package:weather/layers/data/dto/current_units_dto.dart';
import 'package:weather/layers/data/dto/daily_units_entity.dart';
import 'package:weather/layers/data/dto/hourly_dto.dart';
import 'package:weather/layers/data/dto/hourly_units_dto.dart';
import 'package:weather/layers/domain/entity/weather_entity.dart';

// ignore: must_be_immutable
class WeatherDto extends WeatherEentity {
  WeatherDto(
      {super.latitude,
      super.longitude,
      super.generationtimeMs,
      super.utcOffsetSeconds,
      super.timezone,
      super.timezoneAbbreviation,
      super.elevation,
      super.currentUnits,
      super.current,
      super.hourlyUnits,
      super.hourly,
      super.dailyUnits
      });

  factory WeatherDto.fromRawJson(String str) =>
      WeatherDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory WeatherDto.fromMap(Map<String, dynamic> json) => WeatherDto(
        latitude: json['latitude'],
        longitude: json['longitude'],
        generationtimeMs: json['generationtime_ms'],
        utcOffsetSeconds: json['utc_offset_seconds'],
        timezone: json['timezone'],
        timezoneAbbreviation: json['timezone_abbreviation'],
        elevation: json['elevation'],
        hourlyUnits: json['hourly_units'] == null
            ? null
            : HourlyUnitsDto.fromMap(json['hourly_units']),
        hourly:
            json['hourly'] == null ? null : HourlyDto.fromMap(json['hourly']),
        current: json['current'] == null
            ? null
            : CurrentWeatherDto.fromMap(json['current']),
        currentUnits: json['current_units'] == null
            ? null
            : CurrentWeatherUnitsDto.fromMap(json['current_units']),
        dailyUnits: json['daily'] == null
            ? null
            : DailyUnitsDto.fromMap(json['daily']),
      );

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationtimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        // 'hourly_units':hourlyUnits!=null?HourlyUnits.
      };
}
