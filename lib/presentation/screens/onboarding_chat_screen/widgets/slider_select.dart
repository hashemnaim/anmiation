import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';
import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import 'cubit/chatscreen_cubit.dart';

class SliderSelect extends StatefulWidget {
  final QuestionAnswerPair pair;

  SliderSelect({Key key, @required this.pair}) : super(key: key);

  @override
  State<SliderSelect> createState() => _SliderSelectState();
}

class _SliderSelectState extends State<SliderSelect> {
  final List<Color> sliderGradientColors = [
    MyColors.constMainGreen,
    //MyColors.sliderDarkGreen,
    MyColors.sliderGold,
    //MyColors.sliderOrange,
    Colors.red
  ];
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            "Bewege den Slider von links nach rechts",
            style: MyStyles.greyMediumText10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
              child: FlutterSlider(
                handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    disabled: true,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: sliderGradientColors[context
                              .read<ChatscreenCubit>()
                              .getFirstIndexOfSelectedAnswer(
                                  widget.pair.questionText)],
                          shape: BoxShape.circle),
                    )),
                tooltip: FlutterSliderTooltip(disabled: true),
                values: [value],
                min: 0,
                max: 100,
                trackBar: FlutterSliderTrackBar(
                  centralWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSliderDivider(
                          color: MyColors.constMainGreen,
                          activated: context
                                      .read<ChatscreenCubit>()
                                      .getFirstIndexOfSelectedAnswer(
                                          widget.pair.questionText) +
                                  1 ==
                              1),
                      _buildSliderDivider(
                          color: MyColors.sliderGold,
                          activated: context
                                      .read<ChatscreenCubit>()
                                      .getFirstIndexOfSelectedAnswer(
                                          widget.pair.questionText) +
                                  1 ==
                              2),
                      _buildSliderDivider(
                          color: Colors.red,
                          activated: context
                                      .read<ChatscreenCubit>()
                                      .getFirstIndexOfSelectedAnswer(
                                          widget.pair.questionText) +
                                  1 ==
                              3),
                    ],
                  ),
                  activeTrackBar: BoxDecoration(
                    gradient: context
                                    .read<ChatscreenCubit>()
                                    .getFirstIndexOfSelectedAnswer(
                                        widget.pair.questionText) +
                                1 ==
                            1
                        ? null
                        : LinearGradient(
                            colors: sliderGradientColors
                                .getRange(
                                    0,
                                    context
                                            .read<ChatscreenCubit>()
                                            .getFirstIndexOfSelectedAnswer(
                                                widget.pair.questionText) +
                                        1)
                                .toList()),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeTrackBarHeight: 2,
                ),
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  debugPrint([
                    handlerIndex.toString(),
                    lowerValue.toString(),
                    upperValue.toString()
                  ].toString());
                  double newValue = 0;
                  int returnValue = 0;
                  if (![0.0, 50.0, 100.0].contains(lowerValue)) {
                    if (lowerValue as int <= 25) {
                      returnValue = 0;
                      newValue = 0;
                    } else {
                      if (lowerValue as int <= 75) {
                        returnValue = 1;
                        newValue = 50;
                      } else {
                        returnValue = 2;
                        newValue = 100;
                      }
                    }
                    setState(() {
                      value = newValue;
                    });
                  }
                  if (context
                          .read<ChatscreenCubit>()
                          .getFirstIndexOfSelectedAnswer(
                              widget.pair.questionText) !=
                      returnValue) {
                    context.read<ChatscreenCubit>().setAnswer(
                          questionText: widget.pair.questionText,
                          answerText:
                              widget.pair.answers[returnValue].answerText,
                          selected: true,
                        );
                  }
                },
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              widget
                  .pair
                  .answers[context
                      .read<ChatscreenCubit>()
                      .getFirstIndexOfSelectedAnswer(widget.pair.questionText)]
                  .answerText,
              style: MyStyles.normalText15,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSliderDivider({Color color, bool activated}) {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activated ? color : MyColors.lightGrey),
    );
  }
}
