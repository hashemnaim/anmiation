part of 'chatscreen_cubit.dart';

abstract class ChatscreenState extends Equatable {
  final List<QuestionAnswerPair> questionAnswerPairs;

  const ChatscreenState(this.questionAnswerPairs);

  @override
  List<Object> get props => [questionAnswerPairs];
}

class ChatscreenInitial extends ChatscreenState {
  ///[pairs]: use either CHAT_START when in Onboarding, or CHAT_BROKER when after the portfolio
  const ChatscreenInitial(List<QuestionAnswerPair> pairs) : super(pairs);
}

class ChatscreenLoaded extends ChatscreenState {
  ChatscreenLoaded(List<QuestionAnswerPair> questionAnswersPairs)
      : super(questionAnswersPairs);
}
