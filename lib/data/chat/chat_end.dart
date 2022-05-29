// All the risk questions

import '../../domain/models/chat/answer.dart';
import '../../domain/models/chat/question_answer_pair.dart';

const String kMediumRiskAffinity = 'Die Balance macht\'s ⚖️';
const String kMediumLossAffinity = 'Das halte ich aus 💪';
const String kDontKnow = 'Ich weiß es noch nicht 🤔';

//Warning: do not change the order of answers for the environmental impact question & the risk questions,
//because the index is interpreted for the meaning when saving the chatdata to the users preferences in the ChatScreenCubit, method [saveUserData]

const List<QuestionAnswerPair> CHAT_END = [
  QuestionAnswerPair(
    questionText:
        'Sind dir nachhaltige Geldanlagen mit einem positiven Einfluss, also z.B Unternehmen die nachhaltig, sozial oder fair arbeiten wichtig? 🌎',
    interactionType: InteractionType.checkbox,
    answers: [
      Answer(answerText: 'Mir ist das wichtig'),
      Answer(answerText: 'Da bin ich neutral'),
    ],
  ),
  QuestionAnswerPair(
    questionText:
        'Bist du ein risikofreudiger Mensch?\nAuch beim Geld anlegen? 🤔',
    interactionType: InteractionType.slider,
    answers: [
      Answer(answerText: 'Safety first 🛡️'),
      Answer(answerText: kMediumRiskAffinity, selected: true),
      Answer(answerText: 'Absolut 🚀'),
    ],
    defaultSkipFallback: [Answer(answerText: kMediumRiskAffinity)],
  ),
  QuestionAnswerPair(
    questionText: 'Eine gute Voraussetzung! Wie gehst du mit Verlusten um? 📉',
    interactionType: InteractionType.slider,
    answers: [
      Answer(answerText: 'Ich ziehe direkt die Reißleine 🙅‍♀️'),
      Answer(answerText: kMediumLossAffinity, selected: true),
      Answer(answerText: 'Verluste sind Chancen 👌'),
    ],
    defaultSkipFallback: [Answer(answerText: kMediumLossAffinity)],
  ),
  QuestionAnswerPair(
    questionText:
        'Okay, letzte Frage 🙌 Wie lange möchtest du dein Geld investieren? ⏳',
    interactionType: InteractionType.slider,
    answers: [
      Answer(answerText: 'Nur wenige Jahre (< 5 Jahre)'),
      Answer(answerText: kDontKnow, selected: true),
      Answer(answerText: 'Natürlich langfristig (> 10 Jahre)'),
    ],
    defaultSkipFallback: [Answer(answerText: kDontKnow)],
  ),
  QuestionAnswerPair(
    questionText:
        'Wir haben\'s geschafft 🥳 Jetzt kann es losgehen. Nachdem du deine ersten 5 potentiellen Aktien gefunden hast, werde ich dir helfen ein gut aufgestelltes Aktien-Portfolio zusammenzustellen. Bis später 👋',
    interactionType: InteractionType.onboardingEnd,
  ),
];
