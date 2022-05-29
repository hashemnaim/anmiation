import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';


import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import 'cubit/chatscreen_cubit.dart';

class PercentageETF extends StatelessWidget {
  final QuestionAnswerPair pair;

  PercentageETF({Key key, this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: MyColors.textBlack,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Anteil am Portfolio',
            style: MyStyles.mediumWhiteText15.copyWith(fontSize: 17),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  int offset = 0;
                  if (pair.answers.indexWhere((answer) => answer.selected) >
                      0) {
                    offset += 1;
                  }
                  context.read<ChatscreenCubit>().setAnswer(
                      questionText: pair.questionText,
                      answerText: pair
                          .answers[pair.answers
                                  .indexWhere((answer) => answer.selected) -
                              offset]
                          .answerText,
                      selected: true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: MyColors.lightGrey.withOpacity(0.3),
                  ),
                  height: 55,
                  width: 90,
                  child: Center(
                    child: Text(
                      '   -   ',
                      style: MyStyles.mediumWhiteText15,
                    ),
                  ),
                ),
              ),
              Text(
                pair.answers.firstWhere((answer) => answer.selected).answerText,
                style: MyStyles.mediumWhiteText15
                    .copyWith(fontSize: 50, fontWeight: FontWeight.w100),
              ),
              InkWell(
                onTap: () {
                  int offset = 0;
                  if (pair.answers.indexWhere((answer) => answer.selected) <
                      pair.answers.length) {
                    offset += 1;
                  }
                  context.read<ChatscreenCubit>().setAnswer(
                      questionText: pair.questionText,
                      answerText: pair
                          .answers[pair.answers
                                  .indexWhere((answer) => answer.selected) +
                              offset]
                          .answerText,
                      selected: true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: MyColors.lightGrey.withOpacity(0.3),
                  ),
                  height: 55,
                  width: 90,
                  padding: const EdgeInsets.all(18),
                  child: Center(
                    child: Text(
                      '   +   ',
                      style: MyStyles.mediumWhiteText15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
