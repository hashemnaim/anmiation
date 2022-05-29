import '../../domain/models/chat/answer.dart';
import '../../domain/models/chat/data_flow_elements.dart';
import '../../domain/models/chat/question_answer_pair.dart';

const List<QuestionAnswerPair> CHAT_ADD_ETF = [
  QuestionAnswerPair(
    questionText:
        'Wieviel % möchtest du? Ich empfehle dir 50%, damit du auf der sicheren Seite bist.',
    interactionType: InteractionType.percentageETF,
    answers: [
      Answer(
          answerText: '0%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '10%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '20%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '30%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '40%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '50%',
          selected: true,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '60%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '70%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '80%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '90%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
      Answer(
          answerText: '100%',
          selected: false,
          followingPairs: DataFlowElement.endWithETF),
    ],
    defaultFollowingPairs: DataFlowElement.endWithETF,
  ),
];
