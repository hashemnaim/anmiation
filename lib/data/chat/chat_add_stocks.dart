import '../../domain/models/chat/data_flow_elements.dart';
import '../../domain/models/chat/question_answer_pair.dart';

const List<QuestionAnswerPair> CHAT_ADD_STOCKS = [
  QuestionAnswerPair(
      questionText:
          'Sehr gut! Welche Aktien hast du bereits im Depot oder gefallen dir besonders gut? 😊',
      interactionType: InteractionType.addStocks,
      defaultFollowingPairs: DataFlowElement.interests),
];
