import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vario/presentation/core/util.dart';

import '../../../../domain/models/investment_item/rating.dart';
import '../../../../domain/models/investment_item/stock.dart';

import '../../theme/my_colors.dart';

class RatingScale extends StatelessWidget {
  final String assetName;

  final Rating rating;
  RatingScale.stock(Stock stock)
      : assetName = stock.ticker ?? stock.id ?? stock.title,
        rating = stock.rating;
  RatingScale.custom(this.assetName, this.rating);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          height: 2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(1)),
            gradient: LinearGradient(
              end: Alignment.centerRight,
              begin: Alignment.centerLeft,
              colors: [
                MyColors.mainGreen,
                MyColors.mainYellow,
                MyColors.mainRed
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(_getPosition(), 0.0),
          child: SizedBox(
            width: 50,
            child: Column(
              children: [
                const DottedLine(
                  direction: Axis.vertical,
                  lineLength: 15,
                  dashRadius: 3.0,
                  dashLength: 1.5,
                  dashGapLength: 1.5,
                ),
                Align(
                  child: Text(assetName ?? nullDisplay),
                  alignment: const Alignment(0.0, 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _getPosition() {
    assert(rating != null);
    if (rating == const Rating.veryLow()) {
      return -1;
    } else if (rating == const Rating.low()) {
      return -0.5;
    } else if (rating == const Rating.medium()) {
      return 0.0;
    } else if (rating == const Rating.high()) {
      return 0.5;
    } else {
      return 1;
    }
  }
}
