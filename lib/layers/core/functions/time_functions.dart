import 'package:intl/intl.dart';

String convertToAmPm(String dateTimeString) {
  final parsedDate = DateTime.parse(dateTimeString);
  final formatter = DateFormat.jm(); // Example: 5:31 AM
  return formatter.format(parsedDate);
}
