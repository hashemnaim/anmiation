import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/chat/answer.dart';
import 'package:vario/presentation/screens/previous_investments_screen/previous_investments_screen.dart';
import '../../../core/theme/my_styles.dart';

import 'package:vario/domain/models/chat/question_answer_pair.dart';
import '../../../core/helpers/dismiss_keyboard.dart';
import '../../../core/widgets/bottom_arrow_confirm_button.dart';
import 'checkbox_select.dart';
import 'chip_select.dart';
import 'cubit/chatscreen_cubit.dart';
import 'percentage_etf.dart';
import 'slider_select.dart';

class UserInteraction extends StatefulWidget {
  UserInteraction({
    Key key,
    this.pair,
    this.offsetInSec = 0,
  }) : super(key: key);

  final int offsetInSec;
  final QuestionAnswerPair pair;

  @override
  _UserInteractionState createState() => _UserInteractionState();
}

class _UserInteractionState extends State<UserInteraction>
    with TickerProviderStateMixin {
  AnimationController _selectAppearanceController;
  Animation<double> _selectAnimation;

  // TODO (@KoenigTim): The variable is not being used. Please delete or implement
  //  Is there any other constant that is used, e.g. in AnimatedMessage?
  // ignore: unused_field
  static const MILISECONDS_ANSWER_TO_ANSWER = 2000;
  static const MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT = 750;
  static const MILISECONDS_ANIMATEDSIZE_SELECT = 750;

  @override
  void initState() {
    super.initState();
    debugPrint('built UserInteraction');
    _selectAppearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _selectAnimation = CurvedAnimation(
      parent: _selectAppearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _selectAppearanceController
      ..duration =
          const Duration(milliseconds: MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT)
      ..forward();
  }

  @override
  void dispose() {
    _selectAppearanceController.dispose();
    super.dispose();
  }

  void _removeAnswerSelectAndSubmit() {
    _selectAppearanceController
      ..duration =
          const Duration(milliseconds: MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT)
      ..reverse();
    Timer(const Duration(milliseconds: MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT),
        () {
      context.read<ChatscreenCubit>().submitAnswer(
          questionText: widget.pair.questionText, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _selectAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _selectAnimation.value,
          alignment: Alignment.topRight,
          child: _buildSelect(),
        );
      },
    );
  }

  Widget _buildSelect() {
    return BlocBuilder<ChatscreenCubit, ChatscreenState>(
      builder: (context, state) {
        return AnimatedSize(
          duration:
              const Duration(milliseconds: MILISECONDS_ANIMATEDSIZE_SELECT),
          curve: Curves.fastOutSlowIn,
          child: !widget.pair.questionShown
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _UserAnswerInput(widget.pair),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 10),
                        BottomArrowConfirmButton(
                          width: widget.pair.interactionType ==
                                  InteractionType.addStocks
                              ? 270
                              : 150,
                          // TODO: Add a label field instead
                          label: widget.pair.interactionType ==
                                  InteractionType.addStocks
                              ? 'Aktien hinzufügen'
                              : null,

                          onTap: () {
                            dismissKeyboard();
                            //TODO: Pass onTap from pair

                            if (widget.pair.interactionType ==
                                InteractionType.addStocks) {
                              PreviousInvestmentsScreen.show(context);
                              return;
                            }

                            if (widget.pair.interactionType ==
                                InteractionType.proceed) {
                              context.read<ChatscreenCubit>().setAnswer(
                                    questionText: widget.pair.questionText,
                                    answerText:
                                        widget.pair.answers[0].answerText,
                                    selected: true,
                                  );
                            }
                            _removeAnswerSelectAndSubmit();
                          },
                          active: context
                              .read<ChatscreenCubit>()
                              .pairSubmittable(widget.pair),
                        ),
                        // if user can only proceed or end the chat, hide the skip button
                        (widget.pair.interactionType ==
                                    InteractionType.proceed ||
                                widget.pair.interactionType ==
                                    InteractionType.onboardingEnd ||
                                widget.pair.interactionType ==
                                    InteractionType.brokerEnd)
                            ? const SizedBox(width: 10)
                            : InkWell(
                                child: const Text('SKIP',
                                    style: MyStyles.infoText),
                                onTap: () {
                                  if (widget
                                      .pair.defaultSkipFallback.isNotEmpty) {
                                    for (Answer fallbackAnswer
                                        in widget.pair.defaultSkipFallback) {
                                      context.read<ChatscreenCubit>().setAnswer(
                                          questionText:
                                              widget.pair.questionText,
                                          answerText: fallbackAnswer.answerText,
                                          //TODO: Remove selected field for non chip types
                                          selected: true);
                                    }
                                  }

                                  context.read<ChatscreenCubit>().submitAnswer(
                                      questionText: widget.pair.questionText,
                                      context: context,
                                      skipped: true);
                                },
                              ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _UserAnswerInput extends StatelessWidget {
  final QuestionAnswerPair pair;
  const _UserAnswerInput(
    this.pair, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pair.interactionType == InteractionType.none ||
        pair.interactionType == InteractionType.proceed ||
        pair.interactionType == InteractionType.onboardingEnd ||
        pair.interactionType == InteractionType.addStocks)
      return Container();
    else if (pair.interactionType == InteractionType.slider)
      return SliderSelect(pair: pair);
    else if (pair.interactionType == InteractionType.checkbox)
      return CheckboxSelect(pair: pair);
    else if (pair.interactionType == InteractionType.chips)
      return ChipSelect(pair: pair);
    else if (pair.interactionType == InteractionType.percentageETF)
      return PercentageETF(pair: pair);
    else
      throw ArgumentError.value(pair.interactionType.toString(),
          'pair.interactionType', 'type is not defined in _UserAnswerType');
  }
}
