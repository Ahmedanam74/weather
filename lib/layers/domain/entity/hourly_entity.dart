import 'package:equatable/equatable.dart';

class HourlyEntity with EquatableMixin{
  List<String>? time;
  List<double>? temperature2m;
  List<double>? relativeHumidity2m;
  List<double>? precipitationProbability;
  List<int>? weatherCode;
  List<double>? windSpeed10m;
  List<double>? windDirection10m;

  HourlyEntity(
      {this.time,
      this.temperature2m,
      this.relativeHumidity2m,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10m,
      this.windDirection10m});
      
        @override
        // TODO: implement props
        List<Object?> get props => [time,temperature2m,relativeHumidity2m,precipitationProbability,weatherCode,windSpeed10m,windDirection10m];
}
