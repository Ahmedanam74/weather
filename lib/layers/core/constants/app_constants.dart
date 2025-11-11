import 'package:weather/layers/core/constants/app_svg.dart';

class AppConstants {
  static const Map<int, String> dayWeatherIcons = {
    0: AppSvg.day, // Clear sky
    3: AppSvg.cloudyDay, // Cloudy
    61: AppSvg.rainy, // Rain
  };
  static const Map<int, String> nightWeatherIcons = {
    0: AppSvg.night, // Clear sky
    3: AppSvg.cloudyNight, // Cloudy
    61: AppSvg.rainy, // Rain
  };
  static const Map<int, String> weatherDescriptions = {
    0: "Clear Sky",
    1: "Mainly Clear",
    2: "Partly Cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing Rime Fog",
    51: "Light Drizzle",
    53: "Moderate Drizzle",
    55: "Dense Drizzle",
    61: "Light Rain",
    63: "Moderate Rain",
    65: "Heavy Rain",
    66: "Freezing Rain",
    67: "Heavy Freezing Rain",
    71: "Slight Snow",
    73: "Moderate Snow",
    75: "Heavy Snow",
    95: "Thunderstorm",
    96: "Thunderstorm with Hail",
    99: "Severe Thunderstorm",
    // Add more if needed
  };
}
