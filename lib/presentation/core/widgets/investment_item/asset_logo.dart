import 'package:flutter/material.dart';
import '../../helpers/hex_color.dart';

import '../../../../domain/models/investment_item/logo_data.dart';
import '../../../../domain/models/stock_preview.dart';
import '../../theme/my_colors.dart';
import '../svg.dart';

class AssetLogo extends StatelessWidget {
  const AssetLogo(this.logo,
      {this.size = 50,
      this.radius = 4.0,
      this.borderColor = MyColors.borderGrey,
      Key key})
      : super(key: key);

  AssetLogo.fromPreview(
    StockPreview preview, {
    this.size = 50,
    this.radius = 4.0,
    this.borderColor = MyColors.borderGrey,
  }) : logo = preview.logo;

  final LogoData logo;
  final Color borderColor;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        color: convertHex(logo.backgroundHexCode, ignoreEmpty: true),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: PotentialNetworkSvg(
          logo.url,
          color: logo.imageHexCode != null
              ? convertHex(logo.imageHexCode)
              : Colors.white,
          imageType: logo.fileType,
          width: size,
          height: size,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
