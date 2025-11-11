import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/layers/core/errors/exxeptions.dart';
import 'package:weather/layers/data/dto/weather_dto.dart';

const cachedLocationKey = 'CACHED_LOCATION';
const cachedWeatherKey = 'CACHED_WEATHER';

abstract class LocalStorage {
  Future<bool> saveLocation(
      {required double latitude, required double longitude});
  Map<String, dynamic>? loadLocation();
  Future<bool> saveWeather({
    required List<WeatherDto> list,
  });
  List<WeatherDto> loadWeather();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPref;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;
  @override
  Future<bool> saveWeather({
    required List<WeatherDto> list,
  }) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    return _sharedPref.setStringList(cachedWeatherKey, jsonList);
  }

  @override
  List<WeatherDto> loadWeather() {
    final list = _sharedPref.getStringList(cachedWeatherKey);
    return list != null
        ? list.map((e) => WeatherDto.fromRawJson(e)).toList()
        : [];
  }

  @override
  Map<String, dynamic>? loadLocation() {
    final latitude = _sharedPref.getDouble('latitude');
    final longitude = _sharedPref.getDouble('longitude');

    if (latitude != null && longitude != null) {
      return {"latitude": latitude, "longitude": longitude};
    }
    return null;
  }

  @override
  Future<bool> saveLocation({
    required double latitude,
    required double longitude,
  }) async {
    await _sharedPref.setDouble('latitude', latitude);
    await _sharedPref.setDouble('longitude', longitude);
    return true;
  }

  // Load weather data
}
