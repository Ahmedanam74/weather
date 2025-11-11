import 'package:equatable/equatable.dart';

class DailyUnitsEntity with EquatableMixin  {
  List<String>? time;
  List<String>? sunrise;
  List<String>? sunset;

  DailyUnitsEntity({this.time, this.sunrise, this.sunset});
  
  @override
  List<Object?> get props => [time,sunrise,sunset];

 
}