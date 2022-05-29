import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import '../../../../domain/models/investment_item/investment_item.dart';
import '../../../../domain/models/investment_item/stock.dart';
import '../../../../locator.dart';
import '../../../core/theme/my_styles.dart';

class AssetInfosAndSymbols extends StatelessWidget {
  final InvestmentItem item;
  final bool showName;
  const AssetInfosAndSymbols(this.item, {this.showName = false, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _Info _regionInfo;

    if (item is Stock) {
      final Stock stockItem = item;
      String flagEmoji = stockItem.country.emojiId;
      if (!locator<EmojiParser>().hasName(flagEmoji)) {
        debugPrint('$flagEmoji is not a supported emoji.');
        flagEmoji = stockItem.country.id.toUpperCase();
        assert(false, "Emoji $flagEmoji not available");
      }
      _regionInfo = _Info(
        stockItem.country.label,
        flagEmoji,
        // const ExplainTextData('Die Länderverteilung', ExplainTextData.region),
        wrapEmoji: flagEmoji.startsWith('flag'),
      );
    } else {
      _regionInfo = _Info(
        item.region.label,
        item.region.emojiId,
        // const ExplainTextData(
        //     'Die Länderverteilung', ExplainTextData.region
        // )
      );
    }

    return Column(
      children: [
        if (!showName || item.title.isEmpty)
          const Divider()
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Expanded(child: Divider()),
              const SizedBox(width: 18),
              Text(item.title, style: MyStyles.mediumText15),
              const SizedBox(width: 18),
              const Expanded(child: Divider()),
            ],
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            //TODO: Check for safe implementation of flags
            _regionInfo,
            _Info(
              item.sector.label,
              item.sector.emojiId,
              // const ExplainTextData(
              // 'Die Branchenverteilung', ExplainTextData.sector),
            ),
            _Info(
              item.riskClass.label,
              item.riskClass.emojiId,
              // const ExplainTextData(
              // 'Die Risikoverteilung', ExplainTextData.riskClass),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.label, this.emojiId,
      // this.explainData,
      {this.wrapEmoji = true,
      Key key})
      : super(key: key);

  final String label;
  final String emojiId;
  final bool wrapEmoji;
  // final ExplainTextData explainData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      // onTap: () => WhatIsThisScreen.openExplainScreen(
      //     topic: explainData.title,
      //     explanationMarkdown: explainData.description,
      //     context: context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              locator<EmojiParser>()
                  .emojify(wrapEmoji ? ':$emojiId:' : emojiId),
              style: MyStyles.infoText.copyWith(fontSize: 25)),
          const SizedBox(height: 10),
          //TODO: use padding according to ux design on swipe screen & adapt size of emoji
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: MyStyles.infoText,
          ),
        ],
      ),
    ));
  }
}
