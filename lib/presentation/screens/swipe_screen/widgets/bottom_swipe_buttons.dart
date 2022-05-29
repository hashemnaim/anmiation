import 'package:flutter/material.dart';

import '../../../core/theme/my_colors.dart';
import '../util/swipe_button_data.dart';

class BottomSwipeButtons extends StatelessWidget {
  const BottomSwipeButtons(
    this.data, {
    Key key,
  }) : super(key: key);

  final SwipeButtonBehavior data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInteractionButton(MyColors.mainRed, Icons.close, data.onDislike),
        const SizedBox(width: 30),
        _buildInteractionButton(
            MyColors.mainGreen, Icons.favorite_border, data.onLike),
      ],
    );
  }

  Stack _buildInteractionButton(
      Color backgroundColor, IconData icon, VoidCallback onPressed) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: backgroundColor,
              child: Icon(icon),
              heroTag: '$icon',
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
