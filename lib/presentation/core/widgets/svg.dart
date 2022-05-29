import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../theme/my_colors.dart';

class PlatformSvg {
  ///Display SVG Image.
  ///assetName is /assets/assets/$assetName on Web.
  static Widget asset(String assetName,
      {double width,
      double height,
      BoxFit fit = BoxFit.contain,
      Color color,
      Alignment alignment = Alignment.center,
      String semanticsLabel}) {
    if (kIsWeb) {
      return Image.network("/assets/assets/$assetName",
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: alignment,
          semanticLabel: semanticsLabel);
    }
    return SvgPicture.asset(assetName,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        semanticsLabel: semanticsLabel);
  }
}

/// Used for image urls that might be SVGs or other image types.
class PotentialNetworkSvg extends StatelessWidget {
  /// the filetype of the image. Could be 'svg' or 'png' for instance.
  final String imageType;

  final String imageUrl;

  /// If [imageUrl] is a SVG image, the svg will be colored using this hexCode.
  ///
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#", e.g. "F46833"
  ///
  /// Use either [color] or [colorHexCode] for specifying the color.
  final String colorHexCode;

  /// If [imageUrl] is a SVG image, the svg will be colored using this color.
  ///
  /// Use either [color] or [colorHexCode] for specifying the color.
  final Color color;

  final double height;
  final double width;
  final BoxFit fit;

  const PotentialNetworkSvg(this.imageUrl,
      {Key key,
      this.colorHexCode,
      this.color,
      @required this.imageType,
      this.height,
      this.width,
      this.fit = BoxFit.contain})
      : assert(color == null || colorHexCode == null,
            "Use either a Color or a hexCode to define a color."),
        assert(imageType != null && imageType.length > 0),
        super(key: key);

  ImageProvider<Object> get provider {
    assert(!isSvg, "provider should only be called for network images");
    return _imageNetwork.image;
  }

  Image get _imageNetwork {
    //TODO: Handle white/black PNGs?
    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const _LoadingImage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (isSvg)
        ? SvgPicture.network(
            imageUrl,
            height: height,
            width: width,
            fit: fit,
            color: color,
          )
        : _imageNetwork;
  }

  bool get isSvg =>
      imageType?.toLowerCase() == 'svg' || imageUrl.endsWith('.svg');
}

class _LoadingImage extends StatelessWidget {
  const _LoadingImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        child: Container(decoration: BoxDecoration(color: MyColors.grey)));
  }
}
