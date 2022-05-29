import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/investment_item/backend/stock_chart_model_chart.dart';

import '../../helpers/currency_conversion.dart';
import '../../../../domain/models/investment_item/investment_item.dart';

import '../../helpers/format_date.dart';
import '../../theme/my_colors.dart';
import '../../theme/my_styles.dart';
import '../ux/default_loading.dart';
import 'cubit/stock_performance_chart_cubit.dart';
import 'util/chart_period_model.dart';
import 'widgets/highlighted_divider.dart';
import 'widgets/time_period_button.dart';

part 'widgets/chart_y_axis.dart';
part 'widgets/performance_line_chart.dart';

class StockPerformanceChart extends StatelessWidget {
  final InvestmentItem item;
  final bool hideOnError;

  const StockPerformanceChart(
    this.item, {
    this.hideOnError = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StockPerformanceChartCubit(item.id)..getStockData(),
      child: _StockPerformanceChart(),
    );
  }
}

class _StockPerformanceChart extends StatelessWidget {
  static const height = 300.0; //TODO: Make responsive

  static bool hasEnoughData(StockPerformanceChartState state) {
    return state is! StockPerformanceChartError &&
        !(state is StockPerformanceChartLoaded &&
            (state.data == null || state.data.length < 2));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<StockPerformanceChartCubit, StockPerformanceChartState>(
      builder: (context, state) {
        final bool notEnoughVisibleDataAvailable = !hasEnoughData(state);
        if (notEnoughVisibleDataAvailable) {
          //hide chart if it has no data or could not be loaded.
          _printHideExplanation(state);
          return Container();
        }
        return Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 15, right: 7),
                    height: height,
                    width: double.infinity,
                    child: state is StockPerformanceChartLoaded
                        // SHOW CHART
                        ? LayoutBuilder(
                            builder: (ctx, con) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    width: con.maxWidth * 0.95,
                                    child: const PerformanceLineChart(),
                                  ),
                                ],
                              );
                            },
                          )
                        // LOADING
                        : const DefaultLoading()),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Container(
                      height: 1,
                      color: MyColors.lightGrey,
                      width: double.infinity,
                    ),
                    Positioned(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: availableChartPeriods
                              .map((e) => HighlightedDivider(
                                    screenWidth: screenWidth,
                                    selected: e == state.timePeriod,
                                  ))
                              .toList()),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: availableChartPeriods
                          .map((e) => TimePeriodButton(
                              title: e.label,
                              onTap: () => context
                                  .read<StockPerformanceChartCubit>()
                                  .changeTimePeriod(e),
                              screenWidth: screenWidth))
                          .toList()),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _printHideExplanation(StockPerformanceChartState state) {
    debugPrint("PerformanceChart was hidden because");
    if (state is StockPerformanceChartLoaded && state.data.length < 2) {
      debugPrint("Data was only ${state.data.length} elements long.");
    } else if (state is StockPerformanceChartLoaded && state.data == null) {
      debugPrint("Data was null");
    } else if (state is StockPerformanceChartError) {
      debugPrint("an error occured");
    }
  }
}
