class AssetRegion {
  /* the sector id / sector name to reference during interaction with backend etc. */
  String id = null;
/* the sector name translated into users language */
  String name = null;

  AssetRegion();

  @override
  String toString() {
    return 'AssetRegion[id=$id, name=$name, ]';
  }

  AssetRegion.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static List<AssetRegion> listFromJson(List<dynamic> json) {
    return json == null
        ? <AssetRegion>[]
        : json.map((value) => new AssetRegion.fromJson(value)).toList();
  }

  static Map<String, AssetRegion> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AssetRegion>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AssetRegion.fromJson(value));
    }
    return map;
  }
}
