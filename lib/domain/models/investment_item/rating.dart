import 'package:flutter/material.dart';
import '../../../presentation/core/theme/my_colors.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String id;
  final String label;
  final Color color;

  @override
  List<Object> get props => [id];

  static Rating fromDouble(double ratingScore) {
    if (ratingScore == null) return null;
    if (ratingScore < 0)
      throw ArgumentError.value(
          ratingScore, "ratingScore", "must be a positive value.");
    if (ratingScore >= 0.2) {
      if (ratingScore >= 0.4) {
        if (ratingScore >= 0.6) {
          if (ratingScore >= 0.8) {
            return const Rating.veryHigh();
          }
          return const Rating.high();
        }
        return const Rating.medium();
      }
      return const Rating.low();
    }
    return const Rating.veryLow();
  }

  const Rating.veryLow()
      : this.id = 'veryLow',
        this.label = 'Sehr niedrig',
        this.color = MyColors.constMainGreen;
  const Rating.low()
      : this.id = 'low',
        this.label = 'Niedrig',
        this.color = MyColors.constMainGreen;
  const Rating.medium()
      : this.id = 'medium',
        this.label = 'Mittel',
        this.color = MyColors.constMainYellow;
  const Rating.high()
      : this.id = 'high',
        this.label = 'Hoch',
        this.color = MyColors.constMainRed;
  const Rating.veryHigh()
      : this.id = 'veryHigh',
        this.label = 'Sehr hoch',
        this.color = MyColors.constMainRed;
}
