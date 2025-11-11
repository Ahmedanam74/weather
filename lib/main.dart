import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc_observer.dart';
import 'package:weather/injector.dart';
import 'package:weather/layers/core/constants/app_colors.dart';
import 'package:weather/layers/presentation/location/view/location_view.dart';
import 'package:weather/layers/presentation/weather/view/weather_page.dart';

import 'layers/presentation/theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Bloc.observer = MyBlocObserver();
  await initializeGetIt();
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        final colors = isDark ? AppColorsDark : AppColorsLight;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData.light(),  // Optional
          darkTheme: ThemeData.dark(), // Optional
          home: WeatherPage(),
        );
      },
    );
  }
}
