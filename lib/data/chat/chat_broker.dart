import '../../domain/models/chat/answer.dart';
import '../../domain/models/chat/data_flow_elements.dart';
import '../../domain/models/chat/question_answer_pair.dart';

const List<QuestionAnswerPair> CHAT_BROKER = [
  QuestionAnswerPair(
    questionText: 'Das sieht ja schon richtig gut aus!',
    interactionType: InteractionType.none,
  ),
  QuestionAnswerPair(
    questionText:
        'Um deine Investments vor Risiken und Schwankungen zu schützen, empfehle ich dir noch einen ETF hinzuzufügen.',
    interactionType: InteractionType.none,
  ),
  QuestionAnswerPair(
    questionText:
        'Das ist die sicherste und günstigste Methode dein Risiko zu reduzieren. Du zahlst hierfür nur ca. 0.2% Gebühren pro Jahr und streust im Gegenzug dein Geld auf die weltweit größten 1.600 Unternehmen.',
    interactionType: InteractionType.checkbox,
    answers: [
      Answer(answerText: 'Klingt gut!', followingPairs: DataFlowElement.addETF),
      Answer(
          answerText: 'Ich möchte nur in Aktien investieren',
          followingPairs: DataFlowElement.endWithoutETF)
    ],
  ),
];
