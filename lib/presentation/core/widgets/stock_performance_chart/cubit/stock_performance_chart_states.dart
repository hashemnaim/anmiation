part of 'stock_performance_chart_cubit.dart';

abstract class StockPerformanceChartState extends Equatable {
  final ChartPeriod timePeriod;

  const StockPerformanceChartState(this.timePeriod);

  @override
  List<Object> get props => [timePeriod];
}

class StockPerformanceChartInitial extends StockPerformanceChartState {
  const StockPerformanceChartInitial() : super(const ChartPeriod.max());
}

class StockPerformanceChartLoading extends StockPerformanceChartState {
  const StockPerformanceChartLoading(ChartPeriod timePeriod)
      : super(timePeriod);
}

class StockPerformanceChartLoaded extends StockPerformanceChartState {
  final List<StockChartModelChart> data;

  List<int> get xValues => getXValuesByIndex(data);

  const StockPerformanceChartLoaded(
      {@required ChartPeriod timePeriod, @required this.data})
      : super(timePeriod);

  @override
  List<Object> get props => [timePeriod, data];
}

class StockPerformanceChartError extends StockPerformanceChartState {
  // @override
  // final GlobalErrorData error;

  StockPerformanceChartError(ChartPeriod timePeriod) : super(timePeriod);

  // @override
  // List<Object> get props => [error];
}
