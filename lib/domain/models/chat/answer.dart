import 'package:equatable/equatable.dart';

import 'data_flow_elements.dart';

class Answer extends Equatable {
  final String answerText;
  final bool selected;
  final DataFlowElement followingPairs;

  const Answer({
    this.answerText,
    this.selected = false,
    this.followingPairs,
  });

  Answer copyWith({
    String answerText,
    bool selected,
    DataFlowElement followingPairs,
  }) {
    return Answer(
      answerText: answerText ?? this.answerText,
      selected: selected ?? this.selected,
      followingPairs: followingPairs ?? this.followingPairs,
    );
  }

  @override
  List<Object> get props => [answerText, selected, followingPairs];
}
