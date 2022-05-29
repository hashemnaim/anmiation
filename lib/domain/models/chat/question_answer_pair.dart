import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'data_flow_elements.dart';

import 'answer.dart';

class QuestionAnswerPair extends Equatable {
  ///The Question displayed to the user
  final String questionText;

  ///Used to display the UserInteraction Widget as soon as question bubble animation is done
  final bool questionShown;

  ///The Way the user Interacts with the screen
  final InteractionType interactionType;

  ///The List of Answers. Usage depending on InteractionType:
  ///select/select4/Multiselect/Datasecurity -> the options for the user to choose from
  ///other: an empty answer, that is filled with the users entered answer.
  ///The answeres parameter selected is used by the UserInteractionWidget to show and save the answers chosen before submitting
  final List<Answer> answers;

  /// Value used to set the answer to, when the user skips the answer.
  ///
  /// Has to be an element of [answers]. Defaults to an empty list.
  ///
  /// When this list is empty, setAnswer will not be called in the ChatScreenCubit.
  final List<Answer> defaultSkipFallback;

  ///Set to true when the answerbubble & potential reactions can be shown
  final bool answerSubmitted;
  final String answerText;
  final DataFlowElement defaultFollowingPairs;

  const QuestionAnswerPair({
    @required this.questionText,
    @required this.interactionType,
    this.answers = const [],
    this.answerSubmitted = false,
    this.defaultSkipFallback = const [],
    this.answerText,
    this.questionShown = false,
    this.defaultFollowingPairs,
  });

  QuestionAnswerPair copyWith({
    String questionText,
    InteractionType interactionType,
    List<Answer> answers,
    bool answerSubmitted,
    String answerText,
    Answer defaultSkipFallback,
    bool questionShown,
    DataFlowElement defaultFollowingPairs,
  }) {
    return QuestionAnswerPair(
        questionText: questionText ?? this.questionText,
        interactionType: interactionType ?? this.interactionType,
        answers: answers ?? this.answers,
        defaultSkipFallback:
            defaultSkipFallback ?? this.defaultSkipFallback ?? [],
        answerSubmitted: answerSubmitted ?? this.answerSubmitted,
        answerText: answerText ?? this.answerText,
        questionShown: questionShown ?? this.questionShown,
        defaultFollowingPairs:
            defaultFollowingPairs ?? this.defaultFollowingPairs);
  }

  @override
  List<Object> get props => [
        this.questionText,
        this.answers,
        this.answerSubmitted,
        this.questionShown,
        this.answerText
      ];
}

enum InteractionType {
  none,
  proceed,
  slider,
  checkbox,
  chips,
  addStocks,
  percentageETF,
  onboardingEnd,
  brokerEnd,
}
