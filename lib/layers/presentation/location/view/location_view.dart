import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/layers/presentation/location/bloc/location_bloc.dart';
import 'package:weather/layers/presentation/weather/view/weather_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc()..add(CheckInitialConnection()),
      child: LocationView(),
    );
  }
}

class LocationView extends StatelessWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((LocationBloc b) => b.state.status);
    final errorMessege =
        context.select((LocationBloc b) => b.state.errorMessege);
    if (status == LocationStatus.initial || status == LocationStatus.loading) {
      return Center(child: CircularProgressIndicator());
    }
    if (status == LocationStatus.error) {
      return Center(
        child: Text(errorMessege),
      );
    }
    if (status == LocationStatus.loaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WeatherPage()),
        );
      });
    }
    return SizedBox.shrink();
  }
}
