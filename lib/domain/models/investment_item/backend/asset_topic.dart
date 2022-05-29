class AssetTopic {
  /* the topic id / topic name to reference during interaction with backend etc. */
  String id = null;
/* the topic name translated into users language */
  String name = null;
/* the emoji identifier used in https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json */
  String emoji = null;
/* the color used for topic coloring */
  String color = null;

  AssetTopic();

  @override
  String toString() {
    return 'AssetTopic[id=$id, name=$name, emoji=$emoji, color=$color, ]';
  }

  AssetTopic.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'emoji': emoji, 'color': color};
  }

  static List<AssetTopic> listFromJson(List<dynamic> json) {
    return json == null
        ? <AssetTopic>[]
        : json.map((value) => new AssetTopic.fromJson(value)).toList();
  }

  static Map<String, AssetTopic> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AssetTopic>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AssetTopic.fromJson(value));
    }
    return map;
  }
}
