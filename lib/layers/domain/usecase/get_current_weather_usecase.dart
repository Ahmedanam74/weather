import 'package:weather/layers/domain/entity/weather_entity.dart';
import 'package:weather/layers/domain/repository/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository _repository;
  GetWeatherUseCase({required WeatherRepository repository})
      : _repository = repository;
  Future<List<WeatherEentity>> call(
      {double latitude = 15.3694, double longitude = 44.190997}) async {
    final list = await _repository.fetchWeather(
        latitude: latitude, longitude: longitude);
    return list;
  }
}
