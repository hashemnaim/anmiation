import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../screens/swipe_screen/util/swipe_button_data.dart';
import '../../../../domain/models/investment_item/investment_item.dart';
import '../../../screens/swipe_screen/widgets/asset_card_content.dart';
import '../../../screens/swipe_screen/widgets/swipe_asset_logo.dart';
import '../../../screens/swipe_screen/widgets/swipe_picture_app_bar.dart';

class AssetScrollableCard extends StatelessWidget {
  const AssetScrollableCard(
      {Key key, @required this.item, @required this.swipeButtons})
      : super(key: key);

  final InvestmentItem item;
  final SwipeButtonBehavior swipeButtons;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 0.5,
      child: Builder(builder: (context) {
        final _scrollController = ScrollController();

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverStack(children: [
              SwipePictureAppBar(
                _scrollController,
                context: context,
                opacity: 0.1,
                imageUrl: item.imageUrl,
                key: ValueKey(item.imageUrl),
              ),
              AssetCardContent(item, swipeButtons: swipeButtons),
              SwipeAssetLogo(item.logoData),
            ])
          ],
        );
      }),
    );
  }
}
