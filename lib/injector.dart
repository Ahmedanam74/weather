import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/layers/data/source/api/api.dart';
import 'package:weather/layers/data/weather_repository.dart';
import 'package:weather/layers/domain/repository/weather_repository.dart';
import 'package:weather/layers/domain/usecase/get_current_weather_usecase.dart';

import 'layers/data/source/local/local.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetIt() async {
  getIt.registerLazySingleton<Api>(() => ApiImpl());
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register SharedPreferences if needed globally
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register LocalStorage
  getIt.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(sharedPreferences: getIt()),
  );
  getIt.registerFactory<WeatherRepository>(
    () => WeatherRepositoryImp(api: getIt(), localStorage: getIt()),
  );
  getIt.registerFactory(
    () => GetWeatherUseCase(
      repository: getIt(),
    ),
  );
}
