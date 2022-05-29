import 'investment_item/logo_data.dart';
import 'investment_item/sector.dart';
import 'investment_item/stock.dart';
import 'investment_item/stock_risk_class.dart';

//TODO: In presentation Layer verschieben, wenn es nur im Frontend benutzt wird?
class StockPreview {
  final String id;
  final String title;
  final LogoData logo;

  final String location;
  final Sector sector;
  final StockRiskClass risk;

  /// Amount of likes that the previewed investmentitem got from the users.
  ///
  /// Used on [TrendingScreen].
  final int popularity;

  StockPreview(
      {this.title,
      this.location,
      this.logo,
      this.risk,
      this.sector,
      this.popularity,
      this.id});

  StockPreview.fromStock(Stock item, {this.popularity})
      : id = item.id,
        title = item.title,
        location = item.country.label,
        logo = item.logoData,
        risk = item.riskClass,
        sector = item.sector;

  Stock getStock() {
    return Stock(
        id: this.id,
        title: this.title,
        riskClass: this.risk,
        sector: this.sector);
  }
}
