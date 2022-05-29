import 'package:equatable/equatable.dart';

class ChartPeriod extends Equatable {
  /// Label for the button
  final String label;
  final Duration duration;

  /// if stepSize = n, only return every n-th entry for intraDay, only return every n-th day for daily chart
  final int stepSize;

  /// which interval per entry (e.g. 1d, 15min)
  final String interval;

  /// Data for Chart: only get data of the previous n days
  int get days => duration?.inDays;

  const ChartPeriod(this.label, this.duration, this.stepSize,
      [this.interval = '1d']);

  const ChartPeriod.max() : this('MAX', null, null);

  @override
  List<Object> get props => [label, duration, stepSize, interval];
}

const List<ChartPeriod> availableChartPeriods = [
  ChartPeriod.max(),
  // show every month of the past 5 years
  ChartPeriod('5J', Duration(days: 365 * 5), 30),
  // show every week of the past year
  ChartPeriod('1J', Duration(days: 365), 7),
  // show every day of the past month
  ChartPeriod('1M', Duration(days: 31), 1),
  // show every 15 mins of the past 24 hours
  // currently disabled because it's only supported for US Stocks
  // ChartPeriod('1T', Duration(days: 1), 1, '15min'),
];
