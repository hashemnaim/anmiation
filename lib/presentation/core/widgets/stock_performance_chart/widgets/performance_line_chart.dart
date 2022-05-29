part of '../stock_performance_chart.dart';

class PerformanceLineChart extends StatelessWidget {
  const PerformanceLineChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockPerformanceChartCubit, StockPerformanceChartState>(
      builder: (context, state) {
        if (state is StockPerformanceChartLoaded) {
          final data = state.data;

          final double maxY = _getValue(data, math.max);
          final double minY = _getValue(data, math.min);

          return LineChart(LineChartData(
            maxY: maxY,
            minY: minY,
            lineTouchData: LineTouchData(
              getTouchLineStart: (_, __) => _StockPerformanceChart.height,
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: MyColors.grey, dashArray: [1, 2]),
                    FlDotData(getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                          radius: 5,
                          color: Colors.white.withOpacity(0.5),
                          strokeWidth: 2,
                          strokeColor: MyColors.mainGreen);
                    }),
                  );
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                  showOnTopOfTheChartBoxArea: true,
                  maxContentWidth: 100,
                  tooltipBgColor: Colors.transparent,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      return LineTooltipItem(
                          '${touchedSpot.y.toEuro()}\n', MyStyles.mediumText12,
                          children: [
                            TextSpan(
                                text:
                                    '${data[touchedSpot.x.toInt()].date.formatDateStringToolTip()}',
                                style: MyStyles.normalText10
                                    .copyWith(color: MyColors.grey)),
                          ]);
                    }).toList();
                  }),
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                interval: 1,
                showTitles: true,
                reservedSize: 22,
                getTextStyles: (_, __) => MyStyles.normalText10,
                getTitles: (value) {
                  if (state.xValues.contains(value)) {
                    final Duration maxDiff = DateTime.parse(data.last.date)
                        .difference(DateTime.parse(data.first.date));
                    return data[value.toInt()]
                        .date
                        .toString()
                        .formatDateStringXAxis(maxDiff);
                  }
                  return '';
                },
                margin: 16,
              ),
              topTitles: SideTitles(showTitles: false),
              leftTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(
                  interval: (maxY != null && minY != null)
                      ? ((maxY - minY) / 4)
                      : null,
                  showTitles: true,
                  //TODO: check if right style
                  getTextStyles: (_, __) => MyStyles.normalText10),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(data.length,
                    (index) => FlSpot(index.toDouble(), data[index].close)),
                isCurved: true,
                colors: [MyColors.mainGreen],
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                //Gradient under Line
                belowBarData: BarAreaData(
                  show: true,
                  gradientFrom: const Offset(0, 0),
                  gradientTo: const Offset(0, 2),
                  colors: [
                    MyColors.mainGreen.withOpacity(0.7),
                    MyColors.mainGreen.withOpacity(0.0)
                  ],
                ),
              ),
            ],
          ));
        }
        throw UnimplementedError(
            'Chart should only be displayed in Loaded State.');
      },
    );
  }

  /// used for returning max/min value of the chart data.
  double _getValue(
    List<StockChartModelChart> data,
    double Function(double, double) reducer,
  ) {
    assert(data != null);
    final _validData = data.where((element) => element != null);
    assert(_validData.length > 1);
    return _validData.map((e) => e.close).reduce(reducer);
  }
}
