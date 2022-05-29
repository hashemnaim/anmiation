import 'package:equatable/equatable.dart';

import 'backend/asset_region.dart';

class Region extends Equatable {
  final String id;
  final String label;

  String get emojiId {
    if (id == 'europe' || label == "Europa") return 'earth_africa';
    if (id == 'northAmerica' || label == "Nordamerika") return 'earth_americas';
    if (id == 'asia' || label == "Asien") return 'earth_asia';
    if (id == 'other' || label == "Other") return 'earth_americas';
    throw ArgumentError.value(id);
  }

  const Region.Europe()
      : this.id = 'europe',
        this.label = 'Europa';
  const Region.NorthAmerica()
      : this.id = 'northAmerica',
        this.label = 'Nordamerika';
  const Region.Asia()
      : this.id = 'asia',
        this.label = 'Asien';

  Region.fromBackend(AssetRegion region)
      : this.id = region.id,
        this.label = region.name;

  static const List<Region> all = [
    Region.Europe(),
    Region.NorthAmerica(),
    Region.Asia()
  ];
  @override
  List<Object> get props => [id, label];
}
