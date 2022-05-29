import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String label;
  final String id;

  Country(this.id) : this.label = id;

  String get emojiId => 'flag-${id.toLowerCase()}';

  @override
  List<Object> get props => [id, label];
}
