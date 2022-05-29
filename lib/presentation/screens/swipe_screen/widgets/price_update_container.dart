import 'package:flutter/material.dart';

import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import '../../../core/widgets/opinion_container.dart';

class PriceUpdateContainer extends StatelessWidget {
  final String stockTitle;
  final double relativeChange;
  const PriceUpdateContainer(this.stockTitle, this.relativeChange);

  @override
  Widget build(BuildContext context) {
    final String relativeChangeText = (relativeChange.abs() * 100).toString();
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Seit deinem Swipe ist der Kurs von $stockTitle '),
                        relativeChange > 0
                            ? TextSpan(
                                text: 'um $relativeChangeText % gestiegen',
                                style: MyStyles.consultantOpinionText
                                    .copyWith(color: MyColors.mainGreen),
                              )
                            : TextSpan(
                                text: 'um $relativeChangeText % gefallen',
                                style: MyStyles.consultantOpinionText
                                    .copyWith(color: MyColors.mainRed),
                              ),
                        const TextSpan(
                            text:
                                '. Vielleicht ist die Aktie jetzt interessant für dich?')
                      ],
                      style: MyStyles.consultantOpinionText,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: relativeChange > 0
                        ? MyColors.mainGreen
                        : MyColors.mainRed,
                    width: 1),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            Container(
              height: 31,
              width: 113,
              color: Colors.white,
            )
          ],
        ),
        Row(
          children: [
            const Padding(
                padding: EdgeInsets.only(left: 17, right: 10),
                child: VirtualConsultantCircularImage()),
            Text(
              'Update',
              style: MyStyles.mediumText15,
            ),
          ],
        ),
      ],
    );
  }
}
