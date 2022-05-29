import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vario/presentation/core/util.dart';

import '../../../../domain/models/investment_item/investment_item.dart';
import '../../../../domain/models/investment_item/stock.dart';
import '../../../core/helpers/currency_conversion.dart';
import '../../../core/theme/my_styles.dart';
import '../../../core/widgets/investment_item/percent_chip.dart';
import '../../../core/widgets/investment_item/rating_chip.dart';
import '../../../core/widgets/investment_item/rating_scale.dart';
import 'more_button_line.dart';

class SwipeNumberFacts extends StatelessWidget {
  final InvestmentItem asset;
  const SwipeNumberFacts(this.asset, {Key key}) : super(key: key);

  static const Divider _myDivider = const Divider(height: 25);

  @override
  Widget build(BuildContext context) {
    if (asset is Stock) return _buildStock(context, asset);
    throw ArgumentError(
        "There is no NumberFacts implementation for this kind of InvestmentItem yet.");
  }

  Column _buildStock(BuildContext context, Stock stock) {
    return Column(
      children: [
        MoreButtonLine('Zahlen & Fakten', onPressed: () {
          //  showCupertinoModalBottomSheet(
          //   topRadius: const Radius.circular(20),
          //   context: context,
          //   builder: (_) => ProfileScreen.wrapper(stock));
        }),
        const SizedBox(
          height: 10,
        ),
        buildInfoLine(
            title: 'Preis pro Aktie',
            value: Text(stock.pricePerStock?.amount?.toEuro(2) ?? nullDisplay,
                style: MyStyles.mediumText15),
            context: context,
            explanationMarkdown: "ExplainTextData.pricePerStock"),
        _myDivider,
        buildInfoLine(
            title: 'Börsenwert',
            value: Text(stock.valuation.amount?.toEuro(0) ?? nullDisplay,
                style: MyStyles.mediumText15),
            context: context,
            explanationMarkdown: "ExplainTextData.marketvalue"),
        _myDivider,
        buildInfoLine(
            title: 'Ø Rendite pro Jahr',
            value: PercentChip(stock.returnPerYear, clipped: true),
            context: context,
            explanationMarkdown: "ExplainTextData.returnPerYear"),
        _myDivider,
        buildInfoLine(
            title: 'Aktuelles Wachstum',
            value: PercentChip(stock.currentGrowth, clipped: true),
            context: context,
            explanationMarkdown: "ExplainTextData.salesGrowthTwelveMonths"),
        _myDivider,
        buildInfoLine(
            title: 'Bewertung',
            value: RatingChip(stock.rating),
            context: context,
            explanationMarkdown: "ExplainTextData.rating"),
        const SizedBox(height: 5),
        if (stock.rating != null) RatingScale.stock(stock),
        const SizedBox(height: 15)
      ],
    );
  }

  static Widget buildInfoLine(
      {String title,
      Widget value,
      String subtitle,
      BuildContext context,
      String explanationMarkdown}) {
    return InkWell(
      onTap: () {
        // WhatIsThisScreen.openExplainScreen(
        //     topic: title,
        //     explanationMarkdown: explanationMarkdown,
        //     context: context);
      },
      child: Container(
        height: 40,
        child: Row(
          children: [
            subtitle == null
                ? Text(
                    title,
                    style: MyStyles.normalText,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MyStyles.normalText,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: MyStyles.greyMediumText10,
                      )
                    ],
                  ),
            value
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
