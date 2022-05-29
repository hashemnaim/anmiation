import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'logo_data.dart';
import 'regions.dart';

import '../../../presentation/core/helpers/hex_color.dart';
import 'investment_topic.dart';
import 'sector.dart';
import 'stock_risk_class.dart';

abstract class InvestmentItem extends Equatable {
  final String id;
  final String title;
  final String imageUrl;

  /// Used by [PriceUpdateContainer] to indicate how much the asset has gained or lost value since the dislike.
  final double relativeChangeSinceSwipe;

  final Sector sector;
  final Region region;
  final StockRiskClass riskClass;
  final List<InvestmentTopic> topics;

  final String logoUrl;
  final String logoFileType;

  /// Background color of the logo
  final String colorHexCode;
  Color get colorFromHexCode => convertHex(colorHexCode);

  LogoData get logoData => LogoData(logoUrl, logoFileType, colorHexCode);

  final String description;
  final List<String> arguments;
  final int varioScore;

  final double performance;

  const InvestmentItem({
    @required this.id,
    @required this.title,
    @required this.riskClass,
    @required this.topics,
    @required this.logoUrl,
    @required this.imageUrl,
    @required this.description,
    @required this.colorHexCode,
    @required this.logoFileType,
    @required this.sector,
    @required this.region,
    @required this.arguments,
    @required this.varioScore,
    this.relativeChangeSinceSwipe,
    this.performance,
  });

  @override
  List<Object> get props => [id];

  String get assetType;
}
