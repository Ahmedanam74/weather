import 'package:equatable/equatable.dart';
import 'package:weather/layers/domain/entity/current_entity.dart';
import 'package:weather/layers/domain/entity/current_units_entity.dart';
import 'package:weather/layers/domain/entity/daily_units_entity.dart';
import 'package:weather/layers/domain/entity/hourly_entity.dart';
import 'package:weather/layers/domain/entity/hourly_units_entity.dart';

// ignore: must_be_immutable
class WeatherEentity with EquatableMixin {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeatherUnitsEntity? currentUnits;
  CurrentWeatherEntity? current;
  HourlyUnitsEntity? hourlyUnits;
  HourlyEntity? hourly;
  DailyUnitsEntity ?dailyUnits;

  WeatherEentity(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentUnits,
      this.current,
      this.hourlyUnits,
      this.hourly,
      this.dailyUnits
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        latitude,
        longitude,
        generationtimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        current,
        hourlyUnits,
        hourly,
        dailyUnits
      ];
}
