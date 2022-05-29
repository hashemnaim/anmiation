class LogoData {
  final String url;

  /// the filetype of the image. Could be 'svg' or 'png' for instance.
  final String fileType;

  final String backgroundHexCode;

  /// If [url] is a SVG image, the svg will be colored using this hexCode.
  final String imageHexCode;

  const LogoData(this.url, this.fileType, this.backgroundHexCode,
      {this.imageHexCode});
}
