import 'package:vario/infrastructure/util.dart';

import 'asset_region.dart';
import 'asset_sector.dart';
import 'asset_topic.dart';

class SwipeScreenDataModel {
  /* name of the stock */
  String name = null;
/* URL to the logo of the stock */
  String logoUrl = null;
/* the filetype (extension) of the logo (e.g. svg or png) */
  String logoFileType = null;
/* hex code of the color with which the svg file of the stock is to be colored */
  String colorHexCode = null;
/* URL to some picture related to the stock */
  String pictureUrl = null;
/* short description of the stock */
  String description = null;
/* country origin of the asset */
  String country = null;
/* the emoji associated to the stocks country */
  String countryEmoji = null;

  AssetRegion region = null;

  AssetSector sector = null;
/* risk class of the stock */
  String riskClass = null;

  List<AssetTopic> topics = [];
/* calculated based on some constraints */
  int varioScore = null;
/* Rating Score based on PEG Ratio (values between 0 and 1, 1 maximum) */
  double ratingScore = null;
/* important arguments to choose the stock */
  List<String> arguments = [];
/* currency of the finance data */
  String currency = null;
/* most recent price of stock but in desired currency (e.g. if EUR is desired, but original currency is USD, the price will be converted to EUR) (Kennzahlen Preis Pro Aktie) */
  double pricePerStock = null;
/* market value of stock in specific currency (Kennzahlen-Börsenwert) */
  double value = null;
/* average return per year in percent (0.01 as result means 1%) (Kennzahlen Durschnittliche Rendite pro Jahr) */
  double returnPerYear = null;
/* amount af years to calculate returnPerYear */
  int returnYearsCount = null;
/* value in percent, 0.01 as result means 1% (Kennzahlen Aktuelles Umsatzwachstum (letzte 12 Monate)) */
  double currentSalesGrowth = null;
/* ticker to show to the user */
  String ticker = null;
/* profit performance of stock since initial price in %, (e.g. 5% = 0.05) */
  double performance = null;

  SwipeScreenDataModel();

  @override
  String toString() {
    return 'SwipeScreenDataModel[name=$name, logoUrl=$logoUrl, logoFileType=$logoFileType, colorHexCode=$colorHexCode, pictureUrl=$pictureUrl, description=$description, country=$country, countryEmoji=$countryEmoji, region=$region, sector=$sector, riskClass=$riskClass, topics=$topics, varioScore=$varioScore, ratingScore=$ratingScore, arguments=$arguments, currency=$currency, pricePerStock=$pricePerStock, value=$value, returnPerYear=$returnPerYear, returnYearsCount=$returnYearsCount, currentSalesGrowth=$currentSalesGrowth, ticker=$ticker, performance=$performance, ]';
  }

  SwipeScreenDataModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    logoUrl = json['logoUrl'];
    logoFileType = json['logoFileType'];
    colorHexCode = json['colorHexCode'];
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    country = json['country'];
    countryEmoji = json['countryEmoji'];
    region = new AssetRegion.fromJson(json['region']);
    sector = new AssetSector.fromJson(json['sector']);
    riskClass = json['riskClass'];
    topics = AssetTopic.listFromJson(json['topics']);
    varioScore = json['varioScore'];
    ratingScore = getDouble(json['ratingScore']);
    arguments =
        (json['arguments'] as List).map((item) => item as String).toList();
    currency = json['currency'];
    pricePerStock = getDouble(json['pricePerStock']);
    value = getDouble(json['value']);
    returnPerYear = getDouble(json['returnPerYear']);
    returnYearsCount = json['returnYearsCount'];
    currentSalesGrowth = getDouble(json['currentSalesGrowth']);
    ticker = json['ticker'];
    performance = getDouble(json['performance']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'logoFileType': logoFileType,
      'colorHexCode': colorHexCode,
      'pictureUrl': pictureUrl,
      'description': description,
      'country': country,
      'countryEmoji': countryEmoji,
      'region': region,
      'sector': sector,
      'riskClass': riskClass,
      'topics': topics,
      'varioScore': varioScore,
      'ratingScore': ratingScore,
      'arguments': arguments,
      'currency': currency,
      'pricePerStock': pricePerStock,
      'value': value,
      'returnPerYear': returnPerYear,
      'returnYearsCount': returnYearsCount,
      'currentSalesGrowth': currentSalesGrowth,
      'ticker': ticker,
      'performance': performance
    };
  }

  static List<SwipeScreenDataModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <SwipeScreenDataModel>[]
        : json
            .map((value) => new SwipeScreenDataModel.fromJson(value))
            .toList();
  }

  static Map<String, SwipeScreenDataModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SwipeScreenDataModel>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SwipeScreenDataModel.fromJson(value));
    }
    return map;
  }
}
