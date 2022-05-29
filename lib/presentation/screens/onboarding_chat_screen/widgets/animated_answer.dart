import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vario/domain/models/chat/question_answer_pair.dart';
import '../../../core/theme/my_colors.dart';
import '../../../core/theme/my_styles.dart';
import 'cubit/chatscreen_cubit.dart';

//TODO: Remove emmas avatar duplicates (only the newest message from her should have the image)
class AnimatedAnswer extends StatefulWidget {
  AnimatedAnswer({
    Key key,
    this.pair,
    this.context,
    this.offsetInSec = 0,
  }) : super(key: key);

  final int offsetInSec;
  final QuestionAnswerPair pair;
  final BuildContext context;

  @override
  _AnimatedAnswerState createState() => _AnimatedAnswerState();
}

class _AnimatedAnswerState extends State<AnimatedAnswer>
    with TickerProviderStateMixin {
  AnimationController _selectAppearanceController;
  Animation<double> _selectAnimation;

  //TODO (@KoenigTim): Remove field if unnecessary, otherwise implement it in the code
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _selectAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _selectAnimation.value,
          alignment: Alignment.topRight,
          child: _buildAnswerBubble(),
        );
      },
    );
  }

  Widget _buildAnswerBubble() {
    return BlocBuilder<ChatscreenCubit, ChatscreenState>(
      builder: (context, state) {
        return AnimatedSize(
          duration:
              const Duration(milliseconds: MILISECONDS_ANIMATEDSIZE_SELECT),
          curve: Curves.fastOutSlowIn,
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: MyColors.textBlack,
                        ),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 104),
                        margin: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 24, left: 4.75),
                        padding: const EdgeInsets.all(18),
                        child: Text(
                          widget.pair.answerText,
                          style:
                              MyStyles.chatText.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    /*if (_isAnswered)
                        Container(
                          height: 19,
                          width: 19,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white, border: Border.all(color: MyColors.black)),
                          child: Icon(
                            Icons.brush,
                            color: MyColors.black,
                            size: 12,
                          ),
                        )//used for editing the answer*/
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
