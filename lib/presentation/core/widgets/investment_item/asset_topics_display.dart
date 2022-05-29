import 'package:flutter/material.dart';
import '../../theme/my_styles.dart';

import '../../../../domain/models/investment_item/stock.dart';
import '../../theme/my_colors.dart';

class AssetTopicsDisplay extends StatelessWidget {
  final Stock currentStock;

  const AssetTopicsDisplay(this.currentStock, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: currentStock.topics.isNotEmpty
            ?
            // show all chips
            Wrap(
                spacing: 5,
                runSpacing: 8,
                children: currentStock.topics
                    .map((topic) => Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: topic.color.withOpacity(0.2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                topic.label,
                                style: MyStyles.mediumText12
                                    .copyWith(color: topic.color),
                              ),
                            ],
                          ),
                        ))
                    .toList())
            // show no chips :(
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.grey.withOpacity(0.2),
                ),
                child: Text(
                  'Kein Thema vorhanden',
                  style: TextStyle(fontSize: 12, color: MyColors.grey),
                ),
              ));
  }
}
