import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../domain/models/investment_item/analysis_article.dart';
import '../../../core/widgets/analysis_news/analysis_preview.dart';
import '../../../core/widgets/analysis_news/cubit/asset_news_cubit.dart';
import '../../../core/widgets/ux/default_error.dart';
import '../../../core/widgets/ux/default_loading.dart';
import 'more_button_line.dart';

class _AssetNewsPreviewList extends StatelessWidget {
  final List<AnalysisArticle> articles;
  final int amount;

  const _AssetNewsPreviewList(this.articles, this.amount, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) => AnalysisPreview(
            currentAnalysis: articles[i], isAnalysisScreen: false),
        itemCount:
            amount != null ? min(articles.length, amount) : articles.length);
  }
}

class ConnectedAssetNewsPreviewList extends StatelessWidget {
  const ConnectedAssetNewsPreviewList({
    this.limit,
    this.showMoreButton = false,
  }) : assert(
            (limit != null && showMoreButton) ||
                (limit == null && !showMoreButton),
            "The more button should only be displayed when not all news are shown.");

  /// How many previews should be displayed.
  ///
  /// Leave as null to show all available news.
  final int limit;
  final bool showMoreButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetNewsCubit, AssetNewsState>(
      builder: (ctx, state) {
        if (state is AssetNewsLoaded) {
          return showMoreButton && state.articles.isNotEmpty
              ? Column(
                  children: [
                    MoreButtonLine(
                      'Analysen',
                      onPressed: () {
                        //  showCupertinoModalBottomSheet(
                        //   topRadius: const Radius.circular(20),
                        //   context: ctx,
                        //   builder: (_) => const AnalysenScreen());
                      },
                    ),
                    _AssetNewsPreviewList(state.articles, limit)
                  ],
                )
              : _AssetNewsPreviewList(state.articles, limit);
        }
        if (state is AssetNewsError) {
          // TODO: Hide?
          return DefaultError(message: "Fehler aufgetreten :) state.error.errorMessage");
        }
        return const DefaultLoading();
      },
    );
  }
}
