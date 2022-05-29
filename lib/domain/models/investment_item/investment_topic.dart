import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vario/data/interests_data.dart';

import '../../../presentation/core/helpers/hex_color.dart';
import '../interest.dart';
import 'backend/asset_topic.dart';

part '../../../data/investment_topic_data.dart';

class InvestmentTopic extends Equatable {
  final String id;
  final String label;
  final String emojiId;
  final Color color;

  @override
  List<Object> get props => [id, label, color];

  static InvestmentTopic fromId(String id) {
    return all.firstWhere(
        (element) => element.id.toLowerCase() == id.toLowerCase(), orElse: () {
      throw ArgumentError.value(id, 'id', 'InvestmentTopic was not found');
    });
  }

  InvestmentTopic(this.id, this.label, String hexColor, this.emojiId)
      : this.color = convertHex(hexColor) ?? _fallbackColor;

  InvestmentTopic.fromBackend(AssetTopic topicData)
      : this.id = topicData.id,
        this.label = topicData.name,
        this.color =
            convertHex(topicData.color, ignoreEmpty: true) ?? _fallbackColor,
        this.emojiId = topicData.emoji;

  static const _fallbackColor = Color(0xFFCC9429);

  static final List<InvestmentTopic> all = [
    kDigitalisierungTopic,
    kZeitlosTopic,
    kNachhaltigkeitTopic,
    kBusinessTopic,
    kGesundheitTopic,
    kAutomatisierungTopic,
    kCloudTopic,
    kKrisensicherTopic,
    kAITopic,
    kErneuerbareEnergienTopic,
    kECommerceTopic,
    kBiotechnologieTopic,
    kBlockchainTopic,
    kUnterhaltungTopic,
    kElectromobilityTopic,
    kFoodDrinksTopic,
    kFinanztechnologieTopic,
    kIOTTopic,
    kModeBeautyTopic,
    kGamingTopic,
    kReisenFreizeitTopic,
    kImmobilienTopic,
    kSportTopic,
    kRecyclingTopic,
    kSocialMediaTopic,
    kThemenuebergreifendTopic,
    kLuxusTopic,
    kWasserstoffTopic,
    kCyberSecurityTopic,
    kSharingEconomyTopic,
    kRaumfahrtTopic,
    kVirtualRealityTopic,
    kCannabisTopic,
  ];

  static String getInterestText(List<InvestmentTopic> topics) {
    //TODO: Recude complexity, probably overengineered.
    String _interestText = '';
    final bool isShortList = topics.length <= 3;

    for (int i = 0; i < topics.length; i++) {
      if (i < 2 || isShortList) _interestText += topics[i].label;
      if (isShortList) {
        // if the list is shorter than 3 items,
        // add a comma if there is more than one interest + it's not the last interest.
        if (topics.length > 1 && i != topics.length - 1) _interestText += ", ";
      } else {
        // if the list is longer than 3 items,
        if (i == 0) {
          _interestText += ", ";
        } else if (i == 2) {
          // don't add a comma after the second item. Instead, add:
          _interestText += " und ${topics.length - 2} weitere";
          break;
        }
      }
    }
    return _interestText;
  }
}
