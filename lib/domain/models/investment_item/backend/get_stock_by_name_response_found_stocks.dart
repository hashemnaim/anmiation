
import 'asset_region.dart';
import 'asset_sector.dart';

class GetStockByNameResponseFoundStocks {
  /* stockID in Firestore */
  String stockID = null;
/* the corresponding name to the stock */
  String name = null;
/* URL to the logo of the stock */
  String pictureUrl = null;
/* the filetype (extension) of the logo (e.g. svg or png) */
  String pictureFileType = null;
/* hex code of the color with which the svg file of the stock is to be colored */
  String colorHexCode = null;
/* country origin of the asset */
  String country = null;

  AssetRegion region = null;

  AssetSector sector = null;
/* risk class of the stock */
  String risk = null;

  GetStockByNameResponseFoundStocks();

  @override
  String toString() {
    return 'GetStockByNameResponseFoundStocks[stockID=$stockID, name=$name, pictureUrl=$pictureUrl, pictureFileType=$pictureFileType, colorHexCode=$colorHexCode, country=$country, region=$region, sector=$sector, risk=$risk, ]';
  }

  GetStockByNameResponseFoundStocks.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    stockID = json['stockID'];
    name = json['name'];
    pictureUrl = json['pictureUrl'];
    pictureFileType = json['pictureFileType'];
    colorHexCode = json['colorHexCode'];
    country = json['country'];
    region = new AssetRegion.fromJson(json['region']);
    sector = new AssetSector.fromJson(json['sector']);
    risk = json['risk'];
  }

  Map<String, dynamic> toJson() {
    return {
      'stockID': stockID,
      'name': name,
      'pictureUrl': pictureUrl,
      'pictureFileType': pictureFileType,
      'colorHexCode': colorHexCode,
      'country': country,
      'region': region,
      'sector': sector,
      'risk': risk
    };
  }

  static List<GetStockByNameResponseFoundStocks> listFromJson(
      List<dynamic> json) {
    return json == null
        ? <GetStockByNameResponseFoundStocks>[]
        : json
            .map((value) =>
                new GetStockByNameResponseFoundStocks.fromJson(value))
            .toList();
  }

  static Map<String, GetStockByNameResponseFoundStocks> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, GetStockByNameResponseFoundStocks>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new GetStockByNameResponseFoundStocks.fromJson(value));
    }
    return map;
  }
}
