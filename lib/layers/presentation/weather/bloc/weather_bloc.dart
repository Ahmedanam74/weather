import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/layers/domain/entity/weather_entity.dart';
import 'package:weather/layers/domain/usecase/get_current_weather_usecase.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:developer' as dev;
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required GetWeatherUseCase getWeatherUseCase})
      : _getWeatherUseCase = getWeatherUseCase,
        super(WeatherState()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  // FutureOr<void> fetchWeather(event, Emitter<WeatherState> emit) async {
  //   emit(state.copyWith(status: WeatherPageStatus.loading));
  //   final list = await _getWeatherUseCase();
  //   // dev.log("$list");
  //   dev.log("${list[0].hourly!.weatherCode}");
  //   emit(state.copyWith(
  //       status: WeatherPageStatus.success,
  //       weather: List.of(state.weather)..addAll(list)));
  // }
  Future<void> _fetchWeather(
    FetchWeatherEvent event, Emitter<WeatherState> emit) async {
  emit(state.copyWith(status: WeatherPageStatus.loading));

  double latitude = 15.3694;
  double longitude = 44.190997;
  String cityName = 'Sana\'a';

  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;

      // 🏙 Get city name
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? cityName;
      }
    }
  } catch (e) {
    dev.log("Location error: $e");
  }

  final list =
      await _getWeatherUseCase(latitude: latitude, longitude: longitude);

  emit(state.copyWith(
    status: WeatherPageStatus.success,
    weather: List.of(state.weather)..addAll(list),
    cityName: cityName,
  ));
}

  final GetWeatherUseCase _getWeatherUseCase;
}
