import 'package:flutter/material.dart';

import '../../../../domain/models/stock_preview.dart';
import '../../theme/my_styles.dart';
import 'asset_logo.dart';

class AssetPreviewDisplay extends StatelessWidget {
  const AssetPreviewDisplay(this.preview, {Key key}) : super(key: key);
  final StockPreview preview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: AssetLogo.fromPreview(preview),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              preview.title,
              style: MyStyles.normalText,
            ),
            const SizedBox(height: 4),
            Text(
              '${preview.location} · ${preview.sector.label} · ${preview.risk.label}',
              style: MyStyles.greyMediumText10,
            )
          ],
        )
      ],
    );
  }
}
