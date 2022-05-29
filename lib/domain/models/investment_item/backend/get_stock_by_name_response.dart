
import 'get_stock_by_name_response_found_stocks.dart';

class GetStockByNameResponse {
  List<GetStockByNameResponseFoundStocks> foundStocks = [];

  GetStockByNameResponse();

  @override
  String toString() {
    return 'GetStockByNameResponse[foundStocks=$foundStocks, ]';
  }

  GetStockByNameResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    foundStocks =
        GetStockByNameResponseFoundStocks.listFromJson(json['foundStocks']);
  }

  Map<String, dynamic> toJson() {
    return {'foundStocks': foundStocks};
  }

  static List<GetStockByNameResponse> listFromJson(List<dynamic> json) {
    return json == null
        ? <GetStockByNameResponse>[]
        : json
            .map((value) => new GetStockByNameResponse.fromJson(value))
            .toList();
  }

  static Map<String, GetStockByNameResponse> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetStockByNameResponse>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetStockByNameResponse.fromJson(value));
    }
    return map;
  }
}
