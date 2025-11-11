// import 'package:geolocator/geolocator.dart';
import 'package:weather/layers/domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<List<WeatherEentity>> fetchWeather(
      {double latitude = 15.3694, double longitude = 44.190997});
  // Future<Position> determinePosition();
}
