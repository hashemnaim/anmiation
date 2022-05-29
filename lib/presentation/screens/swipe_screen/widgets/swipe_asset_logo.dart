import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'swipe_picture_app_bar.dart';

import '../../../../domain/models/investment_item/logo_data.dart';
import '../../../core/widgets/investment_item/asset_logo.dart';
import '../../swipe_screen/widgets/loading_animation.dart';

class SwipeAssetLogo extends StatelessWidget {
  final LogoData logo;

  const SwipeAssetLogo(this.logo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPositioned(
      child: logo == null
          ? const LogoGrey()
          : Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // Outline
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  width: 85,
                  height: 85,
                ),
                AssetLogo(logo, size: 77, radius: 6, borderColor: null)
              ],
            ),
      top: SwipePictureAppBar.kHeight - 60,
    );
  }
}
