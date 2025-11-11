// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:weather/layers/core/constants/app_svg.dart';

// class WeatherScreen extends StatelessWidget {
//   final List<HourlyForecast> forecast = [
//     HourlyForecast(time: "6 PM", temp: "68°", icon: Icons.wb_sunny),
//     HourlyForecast(time: "6:03 PM", temp: "Sunset", icon: Icons.wb_twilight),
//     HourlyForecast(time: "7 PM", temp: "65°", icon: Icons.nightlight_round),
//     HourlyForecast(time: "8 PM", temp: "62°", icon: Icons.nightlight_round),
//     HourlyForecast(time: "9 PM", temp: "60°", icon: Icons.nightlight_round),
//     HourlyForecast(time: "10 PM", temp: "57°", icon: Icons.nightlight_round),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Hourly Forecast",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: forecast.length,
//                 itemBuilder: (context, index) {
//                   return HourlyWeatherCard(hourlyForecast: forecast[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HourlyForecastCard extends StatelessWidget {
//   const HourlyForecastCard({
//     super.key, required this.time, required this.temp,
//   });
//   final String time;
//   final String temp;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(AppSvg.day),
//           SizedBox(height: 5),
//           Text(
//             time,
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//           SizedBox(height: 5),
//           Text(
//             temp,
//             style: TextStyle(
//                 color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
