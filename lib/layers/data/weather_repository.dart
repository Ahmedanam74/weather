import 'package:weather/layers/data/source/api/api.dart';
import 'package:weather/layers/data/source/local/local.dart';
import 'package:weather/layers/domain/entity/weather_entity.dart';
import 'package:weather/layers/domain/repository/weather_repository.dart';

class WeatherRepositoryImp implements WeatherRepository {
  final Api _api;
  final LocalStorage _localStorage;
  WeatherRepositoryImp({required Api api, required LocalStorage localStorage})
      : _api = api,
        _localStorage = localStorage;
  @override
  Future<List<WeatherEentity>> fetchWeather(
      {double latitude = 15.3694, double longitude = 44.190997}) async {
    final cachedList = _localStorage.loadWeather();
    if (cachedList.isNotEmpty) {
      return cachedList;
    }
    final result =
        await _api.fetchWeather(latitude: latitude, longitude: longitude);
    return result;
  }

  // @override
  // Future<Position> determinePosition() async{
  //   final position = await _api.determinePosition();

  // // Save the location in local storage
  // await _localStorage.saveLocation(
  //   latitude: position.latitude,
  //   longitude: position.longitude,
  // );

  // return position;
  // }
}
