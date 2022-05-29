

import 'stock_chart_model_chart.dart';

class StockChartModel {
  /* stockID in stocks collection */
  String stockID = null;
/* the time interval between each entry */
  String interval = null;
/* if you requested chart data converted in EUR, then this will be EUR */
  String currency = null;
/* list of chart entries */
  List<StockChartModelChart> chart = [];

  StockChartModel();

  @override
  String toString() {
    return 'StockChartModel[stockID=$stockID, interval=$interval, currency=$currency, chart=$chart, ]';
  }

  StockChartModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stockID = json['stockID'];
    interval = json['interval'];
    currency = json['currency'];
    chart = StockChartModelChart.listFromJson(json['chart']);
  }

  Map<String, dynamic> toJson() {
    return {
      'stockID': stockID,
      'interval': interval,
      'currency': currency,
      'chart': chart
    };
  }

  static List<StockChartModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <StockChartModel>[]
        : json.map((value) => new StockChartModel.fromJson(value)).toList();
  }

  static Map<String, StockChartModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StockChartModel>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new StockChartModel.fromJson(value));
    }
    return map;
  }
}
