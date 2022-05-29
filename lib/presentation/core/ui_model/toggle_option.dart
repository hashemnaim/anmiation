import 'package:equatable/equatable.dart';

class ToggleOption<T> extends Equatable {
  final String title;
  final String emoji;
  final T value;

  const ToggleOption(this.title, this.value, [this.emoji]);

  @override
  List<Object> get props => [title, value];
}
