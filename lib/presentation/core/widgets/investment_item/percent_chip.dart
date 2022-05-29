import 'package:flutter/material.dart';
import 'package:vario/presentation/core/util.dart';
import '../../theme/my_styles.dart';


import '../../theme/my_colors.dart';

class PercentChip extends StatelessWidget {
  final double percent;
  final bool clipped;

  /// When the color of the chip will indicate a bad value.
  ///
  /// If [percent] is below or equal to [badLimit], the color will be red for example.
  ///
  /// Defaults to 5%.
  final double badLimit;

  /// When the color of the chip will indicate a medium value.
  ///
  /// If [percent] is below or equal to [okLimit], the color will be medium for example.
  ///
  /// Defaults to 15%.
  final double okLimit;

  /// If true, the displayed value will be [percent] * 100.
  ///
  /// Data is usually fetched from the server as a double, so 0.01 = 1%.
  /// If the data was not preprocessed before, this value should be true.
  ///
  /// Defaults to true.
  final bool multiplyBy100;

  PercentChip(this.percent,
      {@required this.clipped,
      this.multiplyBy100 = true,
      this.badLimit = 5 * 0.01,
      this.okLimit = 15 * 0.01});

  ///method to automatically give the chip the right color depending on the percentage
  Color get _color {
    if (percent == null) return MyColors.grey;

    if (percent <= badLimit)
      return MyColors.constMainRed;
    else if (percent <= okLimit)
      return MyColors.constMainYellow;
    else
      return MyColors.constMainGreen;
  }

  @override
  Widget build(BuildContext context) {
    double displayValue = percent;

    String clippedPercent;
    if (displayValue != null) {
      if (multiplyBy100) displayValue *= 100;
      clippedPercent = clipped
          ? displayValue.toStringAsFixed(0)
          : '${displayValue > 0 ? "+" : ""} ${displayValue.toStringAsFixed(3)}';
    } else {
      clippedPercent = nullDisplay;
    }
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _color.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          '$clippedPercent%',
          style: MyStyles.mediumText12.copyWith(color: _color),
        ),
      ),
    );
  }
}
