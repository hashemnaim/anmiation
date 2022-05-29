import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';

import '../../../../../data/chat/chat_add_etf.dart';
import '../../../../../data/chat/chat_add_stocks.dart';
import '../../../../../data/chat/chat_end.dart';
import '../../../../../data/chat/chat_end_with_etf.dart';
import '../../../../../data/chat/chat_end_without_etf.dart';
import '../../../../../data/chat/chat_interests.dart';
import '../../../../../domain/models/chat/answer.dart';
import '../../../../../domain/models/chat/data_flow_elements.dart';
import '../../../../../domain/models/chat/question_answer_pair.dart';
import '../../../../../domain/models/investment_item/investment_topic.dart';
import '../../../../../domain/models/investment_item/risk_level.dart';
import '../../../../../domain/models/interest.dart';
import '../../../../../locator.dart';
import '../../../../routing/navigation_service.dart';

part 'chatscreen_state.dart';

class ChatscreenCubit extends Cubit<ChatscreenState> {
  ///[pairs]: use either CHAT_START when in Onboarding, or CHAT_BROKER when after the portfolio
  ChatscreenCubit(List<QuestionAnswerPair> pairs)
      : super(ChatscreenInitial(pairs));

  void resetChatWithPairs(List<QuestionAnswerPair> pairs) {
    emit(ChatscreenInitial(pairs));
  }

  QuestionAnswerPair get lastUnansweredPair {
    //TODO @KoenigTim: Is answerSubmitted also true when "skip" was pressed?
    return state.questionAnswerPairs
        .firstWhere((element) => !element.answerSubmitted);
  }

//TODO: move to Data
  static const String DEFAULT_SKIP_ANSWER_TEXT =
      'Das sage ich dir vllt später!😇';

  void saveUserData() {
    int riskPoints;
    //TODO: Use sustainability variable
    // ignore: unused_local_variable
    bool sustainabilityImportant;
    List<String> userInterestsString;
    List<InvestmentTopic> userTopics;
    //TODO: create resulting userPreferences Model & save in AppWide State / Data Management
    //check if answers are alrady given by user
    final bool riskQuestionsAlreadyInList = state.questionAnswerPairs
        .where((pair) => pair.questionText == CHAT_END[1].questionText)
        .isNotEmpty;
    if (riskQuestionsAlreadyInList) {
      //TODO: This looks like those could be function calls.
      //TODO: Refactor risk section into single function
      final bool riskAnswersGiven = state.questionAnswerPairs
              .firstWhere(
                  (pair) => pair.questionText == CHAT_END[1].questionText)
              .answerSubmitted &&
          state.questionAnswerPairs
              .firstWhere(
                  (pair) => pair.questionText == CHAT_END[2].questionText)
              .answerSubmitted &&
          state.questionAnswerPairs
              .firstWhere(
                  (pair) => pair.questionText == CHAT_END[3].questionText)
              .answerSubmitted;
      //if all three risk questions are submitted
      if (riskAnswersGiven) {
        riskPoints = state.questionAnswerPairs
                .firstWhere(
                    (pair) => pair.questionText == CHAT_END[1].questionText)
                .answers
                .indexWhere((answer) => answer.selected) -
            1;
        riskPoints += state.questionAnswerPairs
                .firstWhere(
                    (pair) => pair.questionText == CHAT_END[2].questionText)
                .answers
                .indexWhere((answer) => answer.selected) -
            1;
        riskPoints += state.questionAnswerPairs
                .firstWhere(
                    (pair) => pair.questionText == CHAT_END[3].questionText)
                .answers
                .indexWhere((answer) => answer.selected) -
            1;
      }
    }
    final bool sustainabilityQuestionInList = state.questionAnswerPairs
        .where((pair) => pair.questionText == CHAT_END[0].questionText)
        .isNotEmpty;
    //if the question is up for beeing shown or already shown
    if (sustainabilityQuestionInList) {
      final bool sustainabilityAnswersGiven = state.questionAnswerPairs
          .firstWhere((pair) => pair.questionText == CHAT_END[0].questionText)
          .answerSubmitted;
      //if the question is already answered
      if (sustainabilityAnswersGiven) {
        sustainabilityImportant = state.questionAnswerPairs
                    .firstWhere(
                        (pair) => pair.questionText == CHAT_END[0].questionText)
                    .answers
                    .indexWhere((answer) => answer.selected) ==
                0
            ? true
            : false;
      }
    }
    final bool topicQuestionInList = state.questionAnswerPairs
        .where((pair) => pair.questionText == CHAT_INTERESTS[1].questionText)
        .isNotEmpty;
    if (topicQuestionInList) {
      final bool topicAnswersGiven = state.questionAnswerPairs
          .firstWhere(
              (pair) => pair.questionText == CHAT_INTERESTS[1].questionText)
          .answerSubmitted;

      if (topicAnswersGiven) {
        final QuestionAnswerPair thePair = state.questionAnswerPairs.firstWhere(
            (pair) => pair.questionText == CHAT_INTERESTS[1].questionText);
        final List<Answer> selectedAnswers =
            thePair.answers.where((answer) => answer.selected).toList();
        userInterestsString =
            selectedAnswers.map((answer) => answer.answerText).toList();
        final List<Interest> userInterests = userInterestsString
            .map((topicString) => Interest.all
                .firstWhere((interest) => interest.answerText == topicString))
            .toList();
        //TODO: Save user interests in backend
        userTopics ??= [];
        userTopics.clear();
        for (Interest interest in userInterests) {
          userTopics.addAll(interestsTopicConnection[interest]);
        }
      }
    }

    if (riskPoints != null && userTopics != null) {
      debugPrint('updating userPreferences!');
      debugPrint('results---------------------');
      userTopics.forEach((element) {
        debugPrint(element.label);
      });
      if (userTopics.isEmpty) {
        debugPrint('Was empty!');
      }
      debugPrint(RiskLevel.fromOnboardingScore(riskPoints).label);
      // locator<InvestmentPreferencesService>().updatePreferences(
      //     newTopics: userTopics,
      //     newRiskLevel: RiskLevel.fromOnboardingScore(riskPoints));
      log("implemented in full version", name: "CHAT_SCREEN_CUBIT");
    }
  }

  /// temporarily set the answer, but don't [submitAnswer] yet.
  ///
  /// E.g. is used by Sliders when the user changes the selected input position of the slider.
  void setAnswer(
      {@required String questionText,
      @required String answerText, //TODO: Replace with answer
      @required bool selected}) {
    debugPrint('called setAnswer for answer: ' + answerText);
    final List<QuestionAnswerPair> newQAPairs =
        state.questionAnswerPairs.map((pair) {
      List<Answer> updatedAnswers;
      if (pair.questionText == questionText) {
        if (pair.answers.isEmpty) {
          updatedAnswers = [Answer(answerText: answerText, selected: true)];
        } else {
          updatedAnswers = pair.answers.map((answer) {
            if (answer.answerText == answerText) {
              return answer.copyWith(selected: selected);
            } else {
              if (pair.interactionType == InteractionType.slider ||
                  pair.interactionType == InteractionType.checkbox ||
                  pair.interactionType == InteractionType.percentageETF) {
                debugPrint('set an answer to not selected');
                return answer.copyWith(selected: false);
              } else {
                return answer;
              }
            }
          }).toList();
        }

        updatedAnswers.forEach((element) {
          debugPrint('answerText:' +
              element.answerText +
              ' selected: ' +
              element.selected.toString());
        });
        return pair.copyWith(answers: updatedAnswers);
      }
      return pair;
    }).toList();
    emit(ChatscreenLoaded(newQAPairs));
  }

  //true: Green Submit Button is activated
  bool pairSubmittable(QuestionAnswerPair pair) {
    if (pair.interactionType == InteractionType.chips) {
      //Interests: more than 3 need to be selected
      return pair.answers.where((answer) => answer.selected).length > 2;
    } else if (pair.interactionType == InteractionType.checkbox) {
      return pair.answers.where((answer) => answer.selected).isNotEmpty;
    } else {
      return true;
    }
  }

  /// Send the answer that has been saved using [setAnswer] and go to the next question.
  void submitAnswer(
      {@required String questionText,
      bool skipped = false,
      @required BuildContext context}) {
    //TODO: Pass pair instead
    debugPrint('called submitAnswer for question: ' + questionText);
    // TODO: give variables appropiate names
    final QuestionAnswerPair thePair = state.questionAnswerPairs
        .firstWhere((pair) => pair.questionText == questionText);
    final List<QuestionAnswerPair> newQAPairs =
        state.questionAnswerPairs.map((pair) {
      if (pair.questionText == questionText) {
        // iterated pair == thePair
        if (pair.interactionType != InteractionType.none) {
          return pair.copyWith(
              answerSubmitted: true,
              answerText:
                  skipped ? DEFAULT_SKIP_ANSWER_TEXT : _buildAnswerText(pair));
        }
        return pair.copyWith(answerSubmitted: true);
      }
      return pair;
    }).toList();
    emit(ChatscreenLoaded(newQAPairs));
    if (skipped) {
      if (thePair.defaultFollowingPairs != null) {
        appendChatFlow(thePair.defaultFollowingPairs);
      }
    } else {
      final List<Answer> regardedAnswers = thePair.answers;
      if (regardedAnswers
          .where((answer) => (answer.selected && answer.followingPairs != null))
          .isNotEmpty) {
        appendChatFlow(regardedAnswers
            .firstWhere(
                (answer) => (answer.selected && answer.followingPairs != null))
            .followingPairs);
      } else if (thePair.defaultFollowingPairs != null) {
        appendChatFlow(thePair.defaultFollowingPairs);
      }
    }
    saveUserData();
    if (thePair.interactionType == InteractionType.onboardingEnd) {
      debugPrint("Ok, I'll go to the swipescreen.");
      locator<NavigationService>().navigateAndPreloadSwipeScreen(context);
    }
    if (thePair.interactionType == InteractionType.brokerEnd) {
      // locator<NavigationService>().navigateTo(BrokerOverviewScreen.url);
      log('redirecting in ful version now', name: "CHAT_SCREEN_CUBIT");
    }
  }

  // void skipQuestion({String questionText}) {
  //   final List<QuestionAnswerPair> newQAPairs = state.questionAnswerPairs.map((pair) {
  //     if (pair.questionText == questionText) {
  //       return pair.copyWith(answerSubmitted: true, answerText: DEFAULT_SKIP_ANSWER_TEXT);
  //     }
  //     return pair;
  //   }).toList();
  //   emit(ChatscreenLoaded(newQAPairs));
  //   if (state.questionAnswerPairs.firstWhere((pair) => pair.questionText == questionText).defaultFollowingPairs !=
  //       null) {
  //     appendChatFlow(
  //         state.questionAnswerPairs.firstWhere((pair) => pair.questionText == questionText).defaultFollowingPairs);
  //   }
  // }

  String _buildAnswerText(QuestionAnswerPair pair) {
    String answerString = '';
    if (pair.interactionType == InteractionType.chips) {
      answerString += pair.answers
          .firstWhere((answer) => answer.selected == true)
          .answerText;
      final int countSelectedAnswers =
          pair.answers.where((answer) => answer.selected == true).length;
      if (countSelectedAnswers > 1) {
        answerString +=
            ' und ' + (countSelectedAnswers - 1).toString() + ' weitere';
      }
    } else {
      // TODO: pair.answers.join(', ')
      pair.answers.forEach((answer) {
        if (answer.selected == true) {
          answerString += answer.answerText + ", ";
        }
      });
      if (answerString.endsWith(', ')) {
        final int stringEnd = answerString.lastIndexOf(', ');
        answerString = answerString.substring(0, stringEnd);
      }
    }
    return answerString;
  }

  void setQuestionShown(String questionText) {
    debugPrint('called setQuestionShown');
    final List<QuestionAnswerPair> newQAPairs =
        state.questionAnswerPairs.map((pair) {
      if (pair.questionText == questionText) {
        return pair.copyWith(questionShown: true);
      }
      return pair;
    }).toList();
    emit(ChatscreenLoaded(newQAPairs));
  }

  int _getIndexOfPair(String questionText) {
    final List<QuestionAnswerPair> potentialCurrentPairIndexes = state
        .questionAnswerPairs
        .where((pair) => pair.questionText == questionText)
        .toList();
    if (potentialCurrentPairIndexes.length == 1) {
      return state.questionAnswerPairs
          .indexWhere((pair) => pair.questionText == questionText);
    } else {
      debugPrint(
          'ERROR: more than one one question in states questionAnswerPairs with the same questionText');
      return -2;
    }
  }

  int getFirstIndexOfSelectedAnswer(String questionText) {
    // TODO: It seems like this function gets called 90 times in a single second. That is pretty often.
    //  The implementation also looks pretty resource intensive. Please find a more performant solution.
    // debugPrint('called getFirstIndexOfSelectedAnswer, returning: ' +
    //     state.questionAnswerPairs[_getIndexOfPair(questionText)].answers
    //         .indexWhere((answer) => answer.selected)
    //         .toString());
    return state.questionAnswerPairs[_getIndexOfPair(questionText)].answers
        .indexWhere((answer) => answer.selected);
  }

  bool previousPairAnswered(String questionText) {
    final int index = _getIndexOfPair(questionText);
    if (index > 0) {
      debugPrint('previousPairAnswered returning ' +
          state.questionAnswerPairs[index - 1].answerSubmitted.toString() +
          'for question ' +
          state.questionAnswerPairs[index].questionText);
      return state.questionAnswerPairs[index - 1].answerSubmitted;
    } else {
      return true;
    }
  }

  //TODO: Maybe move this to a service together with the questionAnswerPairs
  // of the chat screen in order to enable easy resetting
  void appendChatFlow(DataFlowElement followingElement) {
    debugPrint('called append flow with' + followingElement.toString());
    List<QuestionAnswerPair> questionsToBeAppended;
    if (followingElement == DataFlowElement.addStocks) {
      questionsToBeAppended = CHAT_ADD_STOCKS;
    }
    if (followingElement == DataFlowElement.interests) {
      questionsToBeAppended = CHAT_INTERESTS;
    }
    if (followingElement == DataFlowElement.end) {
      questionsToBeAppended = CHAT_END;
    }
    if (followingElement == DataFlowElement.addETF) {
      questionsToBeAppended = CHAT_ADD_ETF;
    }
    if (followingElement == DataFlowElement.endWithETF) {
      questionsToBeAppended = CHAT_END_WITH_ETF;
    }
    if (followingElement == DataFlowElement.endWithoutETF) {
      questionsToBeAppended = CHAT_END_WITHOUT_ETF;
    }
    final List<QuestionAnswerPair> newQAPairs =
        List<QuestionAnswerPair>.from(state.questionAnswerPairs) +
            questionsToBeAppended;

    emit(ChatscreenLoaded(newQAPairs));

    debugPrint('finished append flow');
  }
}
