import 'package:intl/intl.dart';

extension CurrencyConversion on double {
  /// Converts a double to Format #.###,## with addable symbol at the end
  String formatDouble([String symbol = '€']) {
    return NumberFormat.currency(locale: 'eu', symbol: symbol).format(this);
  }

  /// Converts double into german Euro format
  //TODO: Add default value for [precisionDigits]?
  String toEuro([int precisionDigits, bool nullOk = false]) {
    if (this == null) {
      if (!nullOk) throw ArgumentError.notNull('this');
      return null; //alternatively, return nullDisplay
    }
    double firstDigits = this;
    String amountInText = '';

    if (1000 <= this && this < 1000000) {
      firstDigits = this / 1000;
      amountInText = 'Tsd.';
    } else if (1000000 <= this && this < 1000000000) {
      firstDigits = this / 1000000;
      amountInText = 'Mio.';
    } else if (1000000000 <= this && this < 1000000000000) {
      firstDigits = this / 1000000000;
      amountInText = 'Mrd.';
    }
    final String formattedNumber = precisionDigits == null
        ? firstDigits.toString().replaceAll('.', ',')
        : firstDigits.toStringAsFixed(precisionDigits).replaceAll('.', ',');
    return "$formattedNumber ${amountInText.isNotEmpty ? amountInText + ' ' : ''}€";
  }
}
