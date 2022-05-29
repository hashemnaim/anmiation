import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/investment_item/analysis_article.dart';
import '../../theme/my_styles.dart';
import '../flushbar.dart';

class AnalysisPreview extends StatelessWidget {
  AnalysisPreview({this.currentAnalysis, this.isAnalysisScreen});

  /// Indicates whether the widget is used on the AnalysisScreen because the width is depending on the screen.
  final bool isAnalysisScreen;
  final AnalysisArticle currentAnalysis;

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd. MMM', 'de_DE').format(currentAnalysis.date);
    return InkWell(
      onTap: () {
        // launchURL(currentAnalysis.url);
        showErrorBar(context, 'In der Hauptversion implementiert :)');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(currentAnalysis.pictureUrl),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Container(
                    width: isAnalysisScreen
                        ? MediaQuery.of(context).size.width - 98
                        : MediaQuery.of(context).size.width - 90,
                    child: Text(
                      currentAnalysis.title,
                      //softWrap: true,
                      overflow: TextOverflow.visible,
                      style: MyStyles.analyseText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    child: Text(
                      '$formattedDate · ${currentAnalysis.source}',
                      style: MyStyles.greyMediumText10,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
