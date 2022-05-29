import 'package:vario/domain/models/investment_item/backend/stock_chart_model_chart.dart';

List<int> getXValuesByIndex(List<StockChartModelChart> data) {
  final double divider = data.length / 5;
  final List<int> reList = [divider ~/ 2];
  for (int i = 0; i < 3; i++) {
    reList.add((reList[i] + divider * 1.5).toInt());
  }

  return reList;
}
