import 'package:vario/infrastructure/util.dart';

class StockChartModelChart {
  /* the price of the chart entry */
  double close = null;
/* the timestamp for the chart entry, intraDay data has the timestamp format \"YYYY-MM-DD hh:mm:ss\" and perDay data has \"YYYY-MM-DD\" */
  String date = null;

  StockChartModelChart();

  @override
  String toString() {
    return 'StockChartModelChart[close=$close, date=$date, ]';
  }

  StockChartModelChart.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    close = getDouble(json['close']);
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    return {'close': close, 'date': date};
  }

  static List<StockChartModelChart> listFromJson(List<dynamic> json) {
    return json == null
        ? <StockChartModelChart>[]
        : json
            .map((value) => new StockChartModelChart.fromJson(value))
            .toList();
  }

  static Map<String, StockChartModelChart> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StockChartModelChart>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new StockChartModelChart.fromJson(value));
    }
    return map;
  }
}
