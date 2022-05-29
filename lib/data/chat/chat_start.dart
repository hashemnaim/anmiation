import '../../domain/models/chat/answer.dart';
import '../../domain/models/chat/data_flow_elements.dart';
import '../../domain/models/chat/question_answer_pair.dart';

List<QuestionAnswerPair> getChatStartPairs() {
  return [
    const QuestionAnswerPair(
      questionText: //TODO: Fix reloading ${locator<SettingsService>().userSettings.name} if user wasn't logged in before!
          'Hey 👋 Ich bin Emma, dein persönlicher Investmentguide. Schön, dass du da bist 😊',
      interactionType: InteractionType.none,
    ),
    const QuestionAnswerPair(
      questionText:
          'Unsere App soll dir dabei helfen Aktien zu finden, die zu dir passen! ',
      interactionType: InteractionType.none,
    ),
    const QuestionAnswerPair(
      questionText:
          'Ich würde dir gerne ein paar Fragen stellen, um dich und deine Interessen besser kennenzulernen, um dir optimale Vorschläge zu liefern 🙌',
      interactionType: InteractionType.none,
    ),
    const QuestionAnswerPair(
      questionText: 'Bist du ready?',
      interactionType: InteractionType.proceed,
      answers: [
        Answer(answerText: 'Ja, lets go! 🤟'),
      ],
    ),
    const QuestionAnswerPair(
      questionText: 'Investierst du bereits in Aktien?',
      interactionType: InteractionType.checkbox,
      answers: [
        Answer(answerText: 'Ja', followingPairs: DataFlowElement.addStocks),
        Answer(answerText: 'Nein', followingPairs: DataFlowElement.interests),
      ],
      defaultFollowingPairs: DataFlowElement.interests,
    ),
  ];
}
