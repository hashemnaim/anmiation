import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/investment_item/investment_item.dart';

import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import '../../../core/widgets/analysis_news/cubit/asset_news_cubit.dart';
import '../../../core/widgets/flushbar.dart';
import '../../../core/widgets/investment_item/asset_topics_display.dart';
import '../../../core/widgets/investment_item/percent_chip.dart';
import '../../../core/widgets/stock_performance_chart/stock_performance_chart.dart';
import '../util/swipe_button_data.dart';
import 'asset_consultant_opinion.dart';
import 'asset_infos_and_symbols.dart';
import 'asset_news_preview_list.dart';
import 'bottom_swipe_buttons.dart';
import 'more_button_line.dart';
import 'number_facts.dart';
import 'price_update_container.dart';
import 'swipe_picture_app_bar.dart';
import 'vario_score.dart';

class AssetCardContent extends StatelessWidget {
  final InvestmentItem asset;

  final SwipeButtonBehavior swipeButtons;
  const AssetCardContent(this.asset, {@required this.swipeButtons, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _opinionText =
        "Mit _stockTitle könntest du dein Portfolio um eine _stockSector-Aktie ergänzen, jedoch hast du bereits viele _stockRisk-Aktien aus der Region _stockRegion.'";
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          // opaque container over the image for the stack
          Container(
              height: SwipePictureAppBar.kHeight, color: Colors.transparent),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(asset.title,
                    textAlign: TextAlign.center, style: MyStyles.titleText),
                const SizedBox(height: 16),
                _buildDescriptionOrUpdate(asset),
                const SizedBox(height: 30),
                if (asset.sector != null &&
                    asset.riskClass != null &&
                    asset.region != null)
                  AssetInfosAndSymbols(asset),
                const SizedBox(height: 16),
                _buildTopicsAndScore(),
                const SizedBox(height: 48),
                if (asset.arguments.isNotEmpty) ..._buildPros(asset),
                const SizedBox(height: 16),
                if (_opinionText.isNotEmpty)
                  AssetConsultantOpinionDisplay(_opinionText),
                const SizedBox(height: 45),
                SwipeNumberFacts(asset),
                _buildPerformance(asset, context),
                const SizedBox(height: 24),
                StockPerformanceChart(asset),
                const SizedBox(height: 45),
                BlocProvider(
                  create: (_) =>
                      AssetNewsCubit(asset.id, asset.title)..fetchNews(),
                  child: const ConnectedAssetNewsPreviewList(
                    limit: 3,
                    showMoreButton: true,
                  ),
                ),
                const SizedBox(height: 10),
                if (swipeButtons.showButtons) ...[
                  const SizedBox(height: 20),
                  BottomSwipeButtons(swipeButtons),
                ],
                const SizedBox(height: 60)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicsAndScore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AssetTopicsDisplay(asset),
        VarioScore(asset.varioScore),
      ],
    );
  }

  Widget _buildDescriptionOrUpdate(InvestmentItem item) {
    if (item.description != null && item.description.isEmpty) {
      return Text(
          'Für ${item.title} sind leider noch keine weiteren Profilinformationen vorhanden.',
          style: MyStyles.descriptionText.copyWith(color: MyColors.grey));
    }
    if (item.relativeChangeSinceSwipe != null)
      return PriceUpdateContainer(item.title, item.relativeChangeSinceSwipe);
    else
      return Text(item.description,
          style: MyStyles.descriptionText, textAlign: TextAlign.left);
  }

  Widget _buildPerformance(InvestmentItem item, BuildContext context) {
    return Column(
      children: [
        MoreButtonLine(
          'Performance',
          onPressed: () {
            showErrorBar(
                context, "Hier kommt noch das Fullscreen Chart rein :)");
            //TODO:connect to performance chart
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('seit Börsengang', style: MyStyles.normalText),
            PercentChip(item.performance, clipped: false),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildPros(InvestmentItem item) {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Was für ${item.title} spricht',
          style: MyStyles.boldText18,
        ),
      ),
      AssetProArguments(item.arguments),
      const SizedBox(height: 20),
    ];
  }
}
