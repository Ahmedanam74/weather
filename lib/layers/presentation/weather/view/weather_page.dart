import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/injector.dart';
import 'package:weather/layers/core/constants/app_colors.dart';
import 'package:weather/layers/core/constants/app_constants.dart';
import 'package:weather/layers/core/constants/app_svg.dart';
import 'package:weather/layers/core/functions/time_functions.dart';
import 'package:weather/layers/domain/entity/weather_entity.dart';
import 'package:weather/layers/domain/usecase/get_current_weather_usecase.dart';
import 'package:weather/layers/presentation/weather/bloc/weather_bloc.dart';

import '../../../core/functions/is_day_function.dart';
import '../../theme/cubit/theme_cubit.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useCase = getIt<GetWeatherUseCase>();
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return BlocProvider(
      create: (context) =>
          WeatherBloc(getWeatherUseCase: useCase)..add(FetchWeatherEvent()),
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //       icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        //       onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        //     )
        //   ],
        // ),
        backgroundColor: isDark
            ? AppColorsDark.background
            : AppColorsLight.background,
        body: WeatherView(isDark: isDark),
      ),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final status = context.select((WeatherBloc b) => b.state.status);
    if (status == WeatherPageStatus.initial ||
        status == WeatherPageStatus.loading) {
      return Center(child: CircularProgressIndicator());
    }
    return _Content(isDark: isDark);
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final weather = context.select((WeatherBloc b) => b.state.weather);
    final cityName = context.select((WeatherBloc b) => b.state.cityName);
    final weatherData = weather[0];

    final hourlyData = weatherData.hourly;
    final hourlyTimes = hourlyData?.time ?? [];
    final hourlyTemps = hourlyData?.temperature2m ?? [];
    final hourlyWeatherCodes = hourlyData?.weatherCode ?? [];
    final weatherIcons = weatherData.current!.isDay == 1
        ? AppConstants.dayWeatherIcons
        : AppConstants.nightWeatherIcons;
    final iconPath =
        weatherIcons[weatherData.current!.weatherCode] ?? AppSvg.day;
    final weatherCode = weatherData.current!.weatherCode;
    final description =
        AppConstants.weatherDescriptions[weatherCode] ?? "Unknown";

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentWeatherCard(
                size: size,
                iconPath: iconPath,
                weatherData: weatherData,
                textTheme: textTheme,
                description: description,
                cityName: cityName,
              ),
              SizedBox(height: 80),
              Container(
                width: size.width,
                height: size.height * .2,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColorsDark.surface
                      : AppColorsLight.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(hourlyTimes.length, (index) {
                      return HourlyForecastCard(
                        time: hourlyTimes[index],
                        temp: "${hourlyTemps[index].toStringAsFixed(1)}°C",
                        weatherCode: hourlyWeatherCodes[index],
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherInfo(
                    size: size,
                    widget: CustomizedColumn(
                      textTheme: textTheme,
                      text:
                          "${weatherData.current!.relativeHumidity2m}${weatherData.currentUnits!.relativeHumidity2m}",
                      svg: AppSvg.humidity,
                      subText: "Humidity",
                    ),
                  ),
                  WeatherInfo(
                    size: size,
                    widget: CustomizedColumn(
                      textTheme: textTheme,
                      text:
                          "${weatherData.current!.windSpeed10m} ${weatherData.currentUnits!.windSpeed10m}",
                      svg: AppSvg.windSpeed,
                      subText: "Wind Speed",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherInfo(
                    size: size,
                    widget: CustomizedColumn(
                      textTheme: textTheme,
                      text:
                          "${weatherData.current!.windDirection10m}${weatherData.currentUnits!.windDirection10m}",
                      svg: AppSvg.windDirection,
                      subText: "Wind Direction",
                    ),
                  ),
                  WeatherInfo(
                    size: size,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomizedColumn(
                          isColored: false,
                          textTheme: textTheme,
                          text: convertToAmPm(
                            weatherData.dailyUnits!.sunrise![0],
                          ),
                          svg: AppSvg.sunrise,
                          subText: "Sunrise",
                        ),
                        CustomizedColumn(
                          isColored: false,
                          textTheme: textTheme,
                          text: convertToAmPm(
                            weatherData.dailyUnits!.sunset![0],
                          ),
                          svg: AppSvg.sunset,
                          subText: "Sunset",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("The Weather channel"),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.size, required this.widget});

  final Size size;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .45,
      height: size.height * .160,
      decoration: BoxDecoration(
        color: AppColors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget,
    );
  }
}

class DailyInfo extends StatelessWidget {
  const DailyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Row(children: [])]);
  }
}

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    super.key,
    required this.size,
    required this.iconPath,

    // required this.list,
    required this.textTheme,
    required this.weatherData,
    required this.description,
    required this.cityName,
  });

  final Size size;
  final String iconPath;
  // final List<WeatherEentity> list;
  final WeatherEentity weatherData;
  final TextTheme textTheme;
  final String description;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weatherData.current!.temperature2m} ${weatherData.currentUnits!.temperature2m}",
                    style: textTheme.displayMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    description,
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    cityName,
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 35),
              SvgPicture.asset(iconPath, width: 150),
            ],
          ),
          // Divider(
          //   color: AppColors.white,
          //   thickness: 0.2,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     CustomizedColumn(
          //       textTheme: textTheme,
          //       text:
          //           "${weatherData.current!.windSpeed10m} ${weatherData.currentUnits!.windSpeed10m}",
          //       svg: AppSvg.windSpeed,
          //       subText: "Wind",
          //     ),
          //     CustomizedColumn(
          //       textTheme: textTheme,
          //       text:
          //           "${weatherData.current!.relativeHumidity2m}${weatherData.currentUnits!.relativeHumidity2m}",
          //       svg: AppSvg.humidity,
          //       subText: "Humidity",
          //     ),
          //     CustomizedColumn(
          //       textTheme: textTheme,
          //       text:
          //           "${weatherData.current!.windDirection10m}${weatherData.currentUnits!.windDirection10m}",
          //       svg: AppSvg.windDirection,
          //       subText: "Wind",
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 50,
          // ),
        ],
      ),
    );
  }
}

class CustomizedColumn extends StatelessWidget {
  const CustomizedColumn({
    super.key,
    required this.textTheme,
    required this.text,
    required this.svg,
    required this.subText,
    this.isColored = true,
  });

  final TextTheme textTheme;
  final String text;
  final String svg;
  final String subText;
  final bool? isColored;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14),
        SvgPicture.asset(
          svg,
          colorFilter: isColored!
              ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
              : null,
          width: 30,
          height: 30,
        ),
        SizedBox(height: 14),
        Text(
          subText,
          style: textTheme.bodySmall!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 14),
        Text(
          text,
          style: textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temp,
    required this.weatherCode,
  });
  final String time;
  final String temp;
  final int weatherCode;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(time);
    final isDay = isDayTime(dateTime);
    final iconPath = isDay
        ? AppConstants.dayWeatherIcons[weatherCode] ?? AppSvg.day
        : AppConstants.nightWeatherIcons[weatherCode] ?? AppSvg.night;

    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.j().format(dateTime),
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 5),
          SvgPicture.asset(iconPath),
          SizedBox(height: 5),
          Text(
            temp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
