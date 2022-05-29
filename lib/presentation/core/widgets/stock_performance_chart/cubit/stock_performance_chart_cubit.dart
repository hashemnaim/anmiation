import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/investment_item/backend/stock_chart_model.dart';
import 'package:vario/domain/models/investment_item/backend/stock_chart_model_chart.dart';
import 'package:vario/presentation/core/widgets/stock_performance_chart/cubit/dummy_data.dart';
import '../util/axis_generation.dart';
import '../util/chart_exceptions.dart';
import '../util/chart_period_model.dart';

part 'stock_performance_chart_states.dart';

class StockPerformanceChartCubit extends Cubit<StockPerformanceChartState> {
  final String stockId;

  StockPerformanceChartCubit(this.stockId)
      : super(const StockPerformanceChartInitial());

  Future<StockChartModel> getDummyStockChart() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return StockChartModel.fromJson(json.decode(kChartData));
  }

  void getStockData([ChartPeriod newTimePeriod]) async {
    emit(StockPerformanceChartLoading(newTimePeriod ?? state.timePeriod));

    try {
      final _timePeriod = state.timePeriod;
      final data = await getDummyStockChart();
      // StocksApi().getStockChart(
      //   stockId,
      //   Euro.backendID,
      //   _timePeriod.interval,
      //   days: _timePeriod.days,
      //   stepSize: _timePeriod.stepSize,
      // );
      if (data.chart.length < 2)
        throw NotEnoughDataException(ArgumentError.value(
                data.chart.toString(),
                'data.chart',
                'Not enough data available. Length of data: ${data.chart.length}')
            .toString());

      emit(StockPerformanceChartLoaded(
        timePeriod: state.timePeriod,
        data: data.chart,
      ));
    } on NotEnoughDataException {
      log('Not Enough Data', name: 'STOCK_PERFORMANCE_CHART_CUBIT');
      // emit(StockPerformanceChartError(
      //     const GlobalErrorData(null, showToUser: false), state.timePeriod));
    } catch (e, stackTrace) {
      rethrow;
      // emit(StockPerformanceChartError(
      //     GlobalErrorData(e, stackTrace: stackTrace), state.timePeriod));
    }
  }

  void changeTimePeriod(ChartPeriod newPeriod) => getStockData(newPeriod);
}
