import 'package:flutter/material.dart';
import 'package:vario/domain/models/chat/answer.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';
import '../../../core/theme/my_styles.dart';
import '../../../core/theme/my_colors.dart';
import 'cubit/chatscreen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChipSelect extends StatelessWidget {
  final QuestionAnswerPair pair;

  ChipSelect({Key key, this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        //TODO: Do you really need to select 3 answers in every ChipSelect?
        // I suggest adding an optional parameter for this Widget that indicates whether a minimum must be selected.
        Text(
          "Wähle mindestens drei dieser Antworten",
          style: MyStyles.greyMediumText10,
        ),
        Container(
          // height: 150,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                      children: _buildChipRow(
                          context, 0, (pair.answers.length / 2).round())),
                  Row(
                      children: _buildChipRow(
                          context,
                          (pair.answers.length / 2).round(),
                          pair.answers.length)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChipRow(
      BuildContext context, int answerIndexStart, int answerIndexEnd) {
    final List<Widget> chips = [];
    for (var i = answerIndexStart; i < answerIndexEnd; i++) {
      chips.add(_Chip(pair: pair, answer: pair.answers[i]));
    }
    return chips;
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    Key key,
    @required this.pair,
    @required this.answer,
  }) : super(key: key);

  final QuestionAnswerPair pair;
  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ChatscreenCubit>().setAnswer(
              questionText: pair.questionText,
              answerText: answer.answerText,
              selected: !answer.selected,
            );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(
              color: answer.selected ? MyColors.mainGreen : Colors.white,
              width: 3),
          color: Colors.white,
        ),
        height: 70,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            answer.answerText,
            style: MyStyles.mediumText12
                .copyWith(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
