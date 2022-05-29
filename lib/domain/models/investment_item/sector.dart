import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../presentation/core/helpers/hex_color.dart';
import '../investment_item/backend/asset_sector.dart';
import '../../../presentation/core/theme/my_colors.dart';

class Sector extends Equatable {
  final String id;
  final String label;
  final String emojiId;
  final Color color;

  const Sector._(
    this.id,
    this.label, [
    this.emojiId = _fallbackEmoji,
    this.color,
  ]);

  static const _fallbackEmoji = 'hammer_and_wrench';

  Sector.fromBackend(AssetSector sectorData)
      : this.id = sectorData?.id,
        this.label = sectorData?.name,
        this.emojiId =
            (sectorData?.emoji != null && sectorData.emoji.isNotEmpty)
                ? sectorData?.emoji
                : _fallbackEmoji,
        this.color = sectorData?.color != null && sectorData.color.isNotEmpty
            ? convertHex(sectorData?.color)
            : MyColors.chartYellow;

  const Sector.Technology()
      : this._('technology', 'Technologie', 'desktop_computer');
  const Sector.Communication()
      : this._('communication', 'Kommunikation', 'iphone');
  const Sector.Health() : this._('health', 'Gesundheit', 'hospital');
  const Sector.Industry() : this._('industry', 'Industrie', 'factory');
  const Sector.Consumables()
      : this._('consumables', 'Verbrauchsgüter', 'beverage_box');
  const Sector.Durables()
      : this._('durables', 'Gebrauchsgüter', 'shopping_bags');
  const Sector.Finance() : this._('finance', 'Finanzen', 'bank');
  const Sector.Ressources() : this._('ressources', 'Rohstoffe', 'gem');
  const Sector.Supplier() : this._('supplier', 'Versorger', 'zap');
  const Sector.RealEstate() : this._('realestate', 'Immobilien', 'house');
  const Sector.Other() : this._('other', 'Sonstiges', 'package');

  // TODO: Add all fetcher in backend and get all possible sectors when user logs in.
  // e.g. get from https://github.com/theappinnovators/vario_backend/blob/dev/Tools/CompleteModelsJSON/sectors.json online
  static const List<Sector> all = [
    Sector.Technology(),
    Sector.Communication(),
    Sector.Health(),
    Sector.Industry(),
    Sector.Consumables(),
    Sector.Durables(),
    Sector.Finance(),
    Sector.Ressources(),
    Sector.Supplier(),
    Sector.RealEstate(),
    Sector.Other()
  ];

  @override
  List<Object> get props => [id, label];
}
