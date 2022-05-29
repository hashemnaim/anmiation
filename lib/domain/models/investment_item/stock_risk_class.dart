import 'package:equatable/equatable.dart';

class StockRiskClass extends Equatable {
  final String id;
  final String label;
  final String emojiId;

  const StockRiskClass._(this.id, this.label, this.emojiId);

  static StockRiskClass fromId(String id) =>
      all.firstWhere((element) => element.id == id, orElse: () {
        throw ArgumentError.value(id, 'id', 'RiskClass does not exist.');
      });

  static const StockRiskClass defensive =
      const StockRiskClass._('defensive', 'Defensiv', 'shield');
  //TODO: Rename all occurences to 'allrounder' instead of standard
  static const StockRiskClass standard =
      const StockRiskClass._('standard', 'Allrounder', 'globe_with_meridians');
  static const StockRiskClass growth =
      const StockRiskClass._('growth', 'Wachstum', 'rocket');
  static const StockRiskClass speculative =
      const StockRiskClass._('speculative', 'Spekulativ', 'boom');

  static const List<StockRiskClass> all = [
    defensive,
    standard,
    growth,
    speculative,
  ];

  @override
  List<Object> get props => [id, label];
}
