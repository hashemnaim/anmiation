class AssetSector {
  /* the sector id / sector name to reference during interaction with backend etc. */
  String id = null;
/* the sector name translated into users language */
  String name = null;
/* the emoji identifier used in https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json */
  String emoji = null;
/* the color used for topic coloring */
  String color = null;

  AssetSector();

  @override
  String toString() {
    return 'AssetSector[id=$id, name=$name, emoji=$emoji, color=$color, ]';
  }

  AssetSector.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'emoji': emoji, 'color': color};
  }

  static List<AssetSector> listFromJson(List<dynamic> json) {
    return json == null
        ? <AssetSector>[]
        : json.map((value) => new AssetSector.fromJson(value)).toList();
  }

  static Map<String, AssetSector> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AssetSector>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AssetSector.fromJson(value));
    }
    return map;
  }
}
