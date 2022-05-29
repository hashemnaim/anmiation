import 'stock_news_model.dart';

class GetStockNewsResponse {
  List<StockNewsModel> stockNews = [];

  GetStockNewsResponse();

  @override
  String toString() {
    return 'GetStockNewsResponse[stockNews=$stockNews, ]';
  }

  GetStockNewsResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stockNews = StockNewsModel.listFromJson(json['stockNews']);
  }

  Map<String, dynamic> toJson() {
    return {'stockNews': stockNews};
  }

  static List<GetStockNewsResponse> listFromJson(List<dynamic> json) {
    return json == null
        ? <GetStockNewsResponse>[]
        : json
            .map((value) => new GetStockNewsResponse.fromJson(value))
            .toList();
  }

  static Map<String, GetStockNewsResponse> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetStockNewsResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetStockNewsResponse.fromJson(value));
    }
    return map;
  }
}
