import 'package:intl/intl.dart';

extension FormatDateTimeString on String {
  String formatDateStringToolTip() {
    final DateFormat format = DateFormat('MMM');
    final date = DateTime.parse(this);
    return '${date.day}.${format.format(date)} ${date.year}';
  }

  String formatDateStringXAxis(Duration maxDiff) {
    //TODO: Add core function for date formatting?
    final DateFormat format = DateFormat('MMM');
    final DateTime date = DateTime.parse(this);
    if (maxDiff >= const Duration(days: 1461)) {
      return date.year.toString();
    } else if (maxDiff <= const Duration(days: 1)) {
      return '${date.hour}:${date.minute}';
    } else if (maxDiff <= const Duration(days: 365)) {
      return '${date.day}.${format.format(date)}';
    } else if (maxDiff > const Duration(days: 365) &&
        maxDiff < const Duration(days: 1461)) {
      return '${date.day}.${format.format(date)}.${date.year}';
    }
    throw Exception('No time Period found');
  }
}
