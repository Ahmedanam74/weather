import 'package:weather/layers/domain/entity/daily_units_entity.dart';

class DailyUnitsDto extends DailyUnitsEntity {
  DailyUnitsDto({super.time, super.sunrise, super.sunset});
  factory DailyUnitsDto.fromMap(Map<String, dynamic> json) => DailyUnitsDto(
        time: json['time'] == null
            ? []
            : List<String>.from(json['time']!.map((x) => x)),
        sunrise: json['sunrise'] == null
            ? []
            : List<String>.from(json['sunrise']!.map((x) => x)),
        sunset: json['sunset'] == null
            ? []
            : List<String>.from(json['sunset']!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'time': time,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}
