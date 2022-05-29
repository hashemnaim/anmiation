import '../currency.dart';
import 'backend/swipe_screen_data_model.dart';
import 'country.dart';
import 'investment_item.dart';
import 'investment_topic.dart';
import 'rating.dart';
import 'regions.dart';
import 'sector.dart';
import 'stock_risk_class.dart';

class Stock extends InvestmentItem {
  final String ticker;
  final Country country;

  final Rating rating;
  final Currency pricePerStock;
  final Currency valuation;
  final double returnPerYear;
  final double currentGrowth;

  const Stock(
      {String id,
      StockRiskClass riskClass,
      String title,
      List<InvestmentTopic> topics,
      String logoUrl,
      String imageUrl,

      ///Backgroundcolor
      String colorHexCode,
      String logoFileType,
      String description,
      Sector sector,
      List<String> arguments,
      int varioScore,
      double performance,
      double relativeChangeSinceSwipe,
      Region region,
      this.country,
      this.ticker,
      this.rating,
      this.currentGrowth,
      this.pricePerStock,
      this.returnPerYear,
      this.valuation})
      : super(
            id: id,
            logoFileType: logoFileType,
            title: title,
            topics: topics,
            performance: performance,
            riskClass: riskClass,
            logoUrl: logoUrl,
            colorHexCode: colorHexCode,
            relativeChangeSinceSwipe: relativeChangeSinceSwipe,
            imageUrl: imageUrl,
            description: description,
            sector: sector,
            region: region,
            arguments: arguments,
            varioScore: varioScore);

  @override
  String get assetType => kAssetType;
  static const String kAssetType = 'STOCK';

  static Stock fromBackend(String id, SwipeScreenDataModel dataItem) {
    return Stock(
      id: id,
      title: dataItem.name,
      logoUrl: dataItem.logoUrl,
      logoFileType: dataItem.logoFileType,
      imageUrl: dataItem.pictureUrl,
      ticker: dataItem.ticker,
      description: dataItem.description,
      country: Country(dataItem.country),
      performance: dataItem.performance,
      sector: Sector.fromBackend(dataItem.sector),
      region: Region.fromBackend(dataItem.region),
      colorHexCode: dataItem.colorHexCode,
      rating: Rating.fromDouble(dataItem.ratingScore),
      riskClass: StockRiskClass.fromId(dataItem.riskClass),
      topics: dataItem.topics
          .where((element) => element != null)
          .map((e) => InvestmentTopic.fromBackend(e))
          .toList(),
      varioScore: dataItem.varioScore,
      arguments: dataItem.arguments,
      pricePerStock: Euro(dataItem.pricePerStock),
      valuation: Euro(dataItem.value?.toDouble()),
      returnPerYear: dataItem.returnPerYear,
      currentGrowth: dataItem.currentSalesGrowth,
    );
  }

  Stock copyWith({
    String id,
    StockRiskClass riskClass,
    String title,
    List<InvestmentTopic> topics,
    String logoUrl,
    String imageUrl,
    String colorHexCode,
    String description,
    Sector sector,
    String location,
    Region region,
    List<String> arguments,
    String logoFileType,
    int varioScore,
    Rating rating,
    Currency pricePerStock,
    Currency valuation,
    Country country,
    String ticker,
    double relativeChangeSinceSwipe,
    double returnPerYear,
    double currentGrowth,
    double performance,
  }) {
    return Stock(
      id: id ?? this.id,
      performance: performance ?? this.performance,
      riskClass: riskClass ?? this.riskClass,
      title: title ?? this.title,
      country: country ?? this.country,
      ticker: ticker ?? this.ticker,
      logoFileType: logoFileType ?? this.logoFileType,
      topics: topics ?? this.topics,
      logoUrl: logoUrl ?? this.logoUrl,
      relativeChangeSinceSwipe:
          relativeChangeSinceSwipe ?? this.relativeChangeSinceSwipe,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      sector: sector ?? this.sector,
      region: region ?? this.region,
      colorHexCode: colorHexCode ?? this.colorHexCode,
      arguments: arguments ?? this.arguments,
      varioScore: varioScore ?? this.varioScore,
      rating: rating ?? this.rating,
      pricePerStock: pricePerStock ?? this.pricePerStock,
      valuation: valuation ?? this.valuation,
      returnPerYear: returnPerYear ?? this.returnPerYear,
      currentGrowth: currentGrowth ?? this.currentGrowth,
    );
  }
}
