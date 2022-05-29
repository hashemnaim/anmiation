import 'package:flutter/material.dart';
import 'package:vario/presentation/core/util.dart';
import '../../theme/my_styles.dart';

import '../../../../domain/models/investment_item/rating.dart';

import '../../theme/my_colors.dart';

class RatingChip extends StatelessWidget {
  final Rating rating;
  const RatingChip(this.rating);
  @override
  Widget build(BuildContext context) {
    final Color color = rating?.color ?? MyColors.grey;
    final String label = rating?.label ?? nullDisplay;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(label, style: MyStyles.mediumText12.copyWith(color: color)),
      ),
    );
  }
}
