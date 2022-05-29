import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vario/presentation/screens/previous_investments_screen/previous_investments_screen.dart';
import '../../../core/theme/my_styles.dart';

import '../../../core/theme/my_colors.dart';

class VarioScore extends StatelessWidget {
  final int score;
  const VarioScore(this.score, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        PreviousInvestmentsScreen.show(context);
        // WhatIsThisScreen.openExplainScreen(
        //     context: context,
        //     explanationMarkdown: ExplainTextData.varioScore,
        //     topic: 'Der Vario Score');
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: score == null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(color: MyColors.borderGrey, width: 2.5))
            : const BoxDecoration(),
        child: score == null
            ? Center(
                child: Text(
                'N/A',
                style: MyStyles.boldText12
                    .copyWith(color: const Color(0x07070734)),
              ))
            : SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    startAngle: 270,
                    endAngle: 270,
                    minimum: 0,
                    maximum: 10,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.1,
                      cornerStyle: CornerStyle.bothFlat,
                      color: MyColors.mainGreen.withOpacity(0.1),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        color: MyColors.mainGreen,
                        value: score.toDouble(),
                        cornerStyle: CornerStyle.bothFlat,
                        width: 0.075,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          positionFactor: 0.1,
                          angle: 90,
                          widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 32,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    score.toStringAsFixed(0),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  alignment: Alignment.bottomLeft,
                                  width: 32,
                                  child: const Text(
                                    '/10',
                                    style: TextStyle(
                                        color: Color(0x34070707),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]))
                    ])
              ]),
      ),
    );
  }
}
