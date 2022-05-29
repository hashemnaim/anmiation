import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';

import '../../../core/theme/my_styles.dart';
import '../../../core/widgets/opinion_container.dart';
import 'cubit/chatscreen_cubit.dart';

class AnimatedQuestion extends StatefulWidget {
  AnimatedQuestion({
    Key key,
    this.offsetInSec = 0,
    @required this.context,
    @required this.pair,
  }) : super(key: key);
  final BuildContext context;
  final QuestionAnswerPair pair;
  final int offsetInSec;
  final Color flashingCircleDarkColor = const Color(0xFF333333);
  final Color flashingCircleBrightColor = const Color(0xFFaec1dd);

  @override
  _AnimatedQuestionState createState() => _AnimatedQuestionState();
}

class _AnimatedQuestionState extends State<AnimatedQuestion>
    with TickerProviderStateMixin {
  AnimationController _appearanceController;
  Animation<double> _indicatorSpaceAnimation;
  Animation<double> _bubbleAnimation;
  AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  bool _showMessageStatus = false;
  bool _showIndicator = true;

  static const MILISECONDS_BLINKING_DOTS = 1500;
  static const MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT = 750;

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _bubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: MILISECONDS_BLINKING_DOTS),
    );
    if (_showIndicator) {
      Timer(Duration(seconds: widget.offsetInSec), () {
        _showMessage();
        Timer(const Duration(seconds: 3), () {
          context
              .read<ChatscreenCubit>()
              .setQuestionShown(widget.pair.questionText);
          if (widget.pair.interactionType == InteractionType.none) {
            context.read<ChatscreenCubit>().submitAnswer(
                questionText: widget.pair.questionText, context: context);
          }
          setState(() {
            _showIndicator = false;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showMessage() {
    _showMessageStatus = true;
    _appearanceController
      ..duration =
          const Duration(milliseconds: MILISECONDS_ANIMATE_SHOW_CHAT_ELEMENT)
      ..forward();
    _repeatingController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return child;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAnimatedBubble(
            animation: _bubbleAnimation,
            bubble: _buildTextBubble(),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBubble({
    @required Animation<double> animation,
    @required Widget bubble,
    @required AlignmentGeometry alignment,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          alignment: alignment,
          child: bubble,
        );
      },
    );
  }

  Widget _buildTextBubble() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: !_showMessageStatus
          ? Container()
          : Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const SizedBox(width: 15),
              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: VirtualConsultantCircularImage(radius: 20),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 157),
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 77, left: 10),
                padding: const EdgeInsets.all(18),
                child: _showIndicator
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFlashingCircle(0),
                          const SizedBox(width: 4),
                          _buildFlashingCircle(1),
                          const SizedBox(width: 4),
                          _buildFlashingCircle(2),
                        ],
                      )
                    : Text(
                        widget.pair.questionText,
                        style: MyStyles.chatText,
                        // Fixes emoji line height (https://github.com/flutter/flutter/issues/28894)
                        // strutStyle: const StrutStyle(forceStrutHeight: true)
                      ),
              ),
            ]),
    );
  }

  Widget _buildFlashingCircle(int index) {
    return AnimatedBuilder(
      animation: _repeatingController,
      builder: (context, child) {
        final circleFlashPercent =
            _dotIntervals[index].transform(_repeatingController.value);
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(widget.flashingCircleDarkColor,
                widget.flashingCircleBrightColor, circleColorPercent),
          ),
        );
      },
    );
  }
}
