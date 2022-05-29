class StockNewsModel {
  /* assetID in stocks collection */
  String symbol = null;
/* news date in format \"YYYY-MM-DD hh:mm:ss\" */
  String publishedDate = null;
/* title of article */
  String title = null;
/* image URL */
  String image = null;
/* name of source website */
  String site = null;
/* short summary of article */
  String text = null;
/* URL of article source */
  String url = null;

  StockNewsModel();

  @override
  String toString() {
    return 'StockNewsModel[symbol=$symbol, publishedDate=$publishedDate, title=$title, image=$image, site=$site, text=$text, url=$url, ]';
  }

  StockNewsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    symbol = json['symbol'];
    publishedDate = json['publishedDate'];
    title = json['title'];
    image = json['image'];
    site = json['site'];
    text = json['text'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'publishedDate': publishedDate,
      'title': title,
      'image': image,
      'site': site,
      'text': text,
      'url': url
    };
  }

  static List<StockNewsModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <StockNewsModel>[]
        : json.map((value) => new StockNewsModel.fromJson(value)).toList();
  }

  static Map<String, StockNewsModel> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, StockNewsModel>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new StockNewsModel.fromJson(value));
    }
    return map;
  }
}
