import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';
import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import 'cubit/chatscreen_cubit.dart';

class CheckboxSelect extends StatelessWidget {
  final QuestionAnswerPair pair;

  CheckboxSelect({Key key, this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: MyColors.textBlack,
          ),
          margin: const EdgeInsets.only(top: 5, bottom: 5, right: 24, left: 24),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (var i = 0; i < pair.answers.length; i++)
                Column(
                  key: Key(i.toString()),
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context.read<ChatscreenCubit>().setAnswer(
                              questionText: pair.questionText,
                              answerText: pair.answers[i].answerText,
                              selected: true,
                            );
                      },
                      child: Row(
                        children: [
                          Container(
                            child: pair.answers[i].selected
                                ? Center(
                                    child: SvgPicture.asset(
                                    'assets/icons/checkmark.svg',
                                    color: Colors.white,
                                  ))
                                : null,
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: pair.answers[i].selected
                                  ? MyColors.constMainGreen
                                  : Colors.white,
                              border: Border.all(color: MyColors.borderGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              pair.answers[i].answerText,
                              style: MyStyles.normalText16
                                  .copyWith(color: Colors.white),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i != pair.answers.length - 1) ...[
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.white.withOpacity(0.1),
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
