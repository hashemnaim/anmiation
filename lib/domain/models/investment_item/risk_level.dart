import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'stock_risk_class.dart';

///The Risk Level of a userprofile.
///
///Determines the recommended proportions of the stocks with different [StockRiskClass]es.
///
/// A user with a very low RiskLevel is risk-averse,
/// whereas a user with a very high RiskLevel is very risk-taking.
class RiskLevel extends Equatable {
  final String id;
  final String description;
  final String label;
  final _Threshold onboardingScoreThreshold;

  @override
  List<Object> get props => [id, description, label];

  const RiskLevel._(this.id, this.label,
      {@required this.onboardingScoreThreshold, this.description});

  /// Calculates the RiskLevel of the user with the score result from the onboarding chat.
  static RiskLevel fromOnboardingScore(int score) {
    for (RiskLevel level in all) {
      if (level.onboardingScoreThreshold.isInRange(score)) {
        return level;
      }
    }
    throw ArgumentError.value(score, 'score',
        'Impossible amount of points, no RiskLevel for the user fits the requirements.');
  }

  static RiskLevel fromId(String id) =>
      all.firstWhere((element) => element.id == id);

  const RiskLevel.VeryLow()
      : this._(
          'veryLow',
          'Sehr niedrig',
          onboardingScoreThreshold: const _Threshold.range(-3, -2),
          description: 'Du siehst vermehrt defensive Aktien.',
        );
  const RiskLevel.Low()
      : this._(
          'low',
          'Niedrig',
          onboardingScoreThreshold: const _Threshold(-1),
          description: 'Du siehst primär Allrounder-Aktien.',
        );
  const RiskLevel.Normal()
      : this._(
          'normal',
          'Normal',
          onboardingScoreThreshold: const _Threshold(0),
          description:
              'Du siehst einen gleichmäßigen Mix aus allen Kategorien.',
        );
  const RiskLevel.High()
      : this._(
          'high',
          'Hoch',
          onboardingScoreThreshold: const _Threshold(1),
          description: 'Du siehst primär Wachstums-Aktien.',
        );

  const RiskLevel.VeryHigh()
      : this._(
          'veryHigh',
          'Sehr hoch',
          onboardingScoreThreshold: const _Threshold.range(2, 3),
          description: 'Du siehst vermehrt spekulative Aktien.',
        );

  static const List<RiskLevel> all = [
    RiskLevel.VeryLow(),
    RiskLevel.Low(),
    RiskLevel.Normal(),
    RiskLevel.High(),
    RiskLevel.VeryHigh()
  ];
}

class _Threshold {
  final num minimum;
  final num maximum;

  const _Threshold.range(this.minimum, this.maximum);
  const _Threshold(num threshold)
      : this.minimum = threshold,
        this.maximum = threshold;

  bool isInRange(num value) {
    if (value == minimum || value == maximum) return true;
    if (value < maximum && value > minimum) return true;
    return false;
  }
}
