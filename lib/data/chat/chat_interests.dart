import '../../domain/models/chat/answer.dart';
import '../../domain/models/chat/data_flow_elements.dart';
import '../../domain/models/chat/question_answer_pair.dart';
import '../../domain/models/interest.dart';

final List<Answer> _kAllInterestAnswers = Interest.all
    .map(
      (topic) => Answer(
        answerText: topic.answerText,
        followingPairs: DataFlowElement.end,
      ),
    )
    .toList();

List<QuestionAnswerPair> CHAT_INTERESTS = [
  const QuestionAnswerPair(
    questionText:
        'Um die passenden Aktien für dich zu finden, helfen mir deine Interessen sehr weiter. Das alles bleibt natürlich unter uns 🤞',
    interactionType: InteractionType.none,
  ),
  QuestionAnswerPair(
      questionText: 'Für was schlägt dein Herz? Was interessiert dich?',
      interactionType: InteractionType.chips,
      defaultSkipFallback: _kAllInterestAnswers,
      defaultFollowingPairs: DataFlowElement.end,
      answers: _kAllInterestAnswers),
];
