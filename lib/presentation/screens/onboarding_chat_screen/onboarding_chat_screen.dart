import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/virtual_consultant_data.dart';
import '../../core/theme/my_colors.dart';
import '../../core/theme/my_styles.dart';
import 'widgets/animated_answer.dart';
import 'widgets/animated_question.dart';
import 'widgets/chat_start_consultant.dart';
import 'widgets/cubit/chatscreen_cubit.dart';
import 'widgets/user_interaction.dart';

class OnboardingChatScreen extends StatefulWidget {
  OnboardingChatScreen({Key key}) : super(key: key);
  static const String route = '/chat';

  @override
  _OnboardingChatScreenState createState() => _OnboardingChatScreenState();
}

class _OnboardingChatScreenState extends State<OnboardingChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBarConsultantChat(),
        backgroundColor: MyColors.searchBarGrey,
        body: SingleChildScrollView(
          reverse: true,
          child: BlocBuilder<ChatscreenCubit, ChatscreenState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ChatStartConsultant(),
                  ...state.questionAnswerPairs.map((pair) {
                    if (context
                        .watch<ChatscreenCubit>()
                        .previousPairAnswered(pair.questionText)) {
                      return Column(
                        children: [
                          AnimatedQuestion(
                            pair: pair,
                            context: context,
                            offsetInSec: 1,
                          ),
                          if (pair.questionShown && !pair.answerSubmitted)
                            UserInteraction(pair: pair),
                          if (pair.answerSubmitted == true &&
                              pair.answerText != null &&
                              pair.answerText != '')
                            AnimatedAnswer(pair: pair, context: context),
                        ],
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ));
  }
}

Widget _buildAppBarConsultantChat() {
  return AppBar(
    elevation: 1,
    // shadowColor: MyColors.constDarkGrey.withOpacity(0.05),
    centerTitle: true,
    title: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 5.0,
            height: 5.0,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            virtualConsultantName,
            style: MyStyles.mediumText12.copyWith(fontSize: 16),
          )
        ],
      ),
      const SizedBox(height: 2),
      Text(
        'Persönlicher Investmentguide',
        style: MyStyles.mediumText10.copyWith(color: MyColors.grey),
      ),
    ]),

    backgroundColor: Colors.white,
  );
}
