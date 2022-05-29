import '../../presentation/core/helpers/currency_conversion.dart';

import 'package:equatable/equatable.dart';

abstract class Currency extends Equatable {
  final double amount;
  final String symbol;

  ///The id for the backend when a currency is required.
  final String id;

  @override
  String toString([bool showDecimals = true]) {
    return amount.toEuro(showDecimals ? 2 : 0);
  }

  const Currency(this.amount, this.symbol, this.id);

  @override
  List<Object> get props => [amount, symbol];
}

class Euro extends Currency {
  static const String backendID = "EUR";
  static const String kSymbol = "€";

  const Euro(double amount) : super(amount, kSymbol, backendID);
}
