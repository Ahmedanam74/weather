import 'package:dio/dio.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:weather/layers/data/dto/weather_dto.dart';

abstract class Api {
  Future<List<WeatherDto>> fetchWeather(
      {double latitude = 15.3694, double longitude = 44.190997});
  // Future<Position> determinePosition();
}

class ApiImpl implements Api {
  final dio = Dio();
  @override
  Future<List<WeatherDto>> fetchWeather(
      {double latitude = 15.3694, double longitude = 44.190997}) async {
    final dio = Dio();
    try {
      Response response;
      response = await dio.get(
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m,wind_direction_10m&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,wind_speed_10m,wind_direction_10m&forecast_days=1&daily=sunrise,sunset&timezone=auto');
      // print(response);
      final temp = [];
      temp.add(response.data);
      final l = temp.map((e) => WeatherDto.fromMap(e)).toList();
      // print(l);
      return l;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        //  API responds with 404 when reached the end
        if (e.response?.statusCode == 404) return [];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    print("error====");
    return [];
  }

  // @override
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
}
