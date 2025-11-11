bool isDayTime(DateTime dateTime) {
  final hour = dateTime.hour;
  return hour >= 6 && hour < 18; // Daytime is between 6 AM and 6 PM
}