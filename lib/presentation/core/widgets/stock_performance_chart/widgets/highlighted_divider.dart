import 'package:flutter/material.dart';

import '../../../theme/my_colors.dart';

class HighlightedDivider extends StatelessWidget {
  final double screenWidth;
  final bool selected;

  const HighlightedDivider({Key key, this.screenWidth, this.selected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //width: (screenWidth - 30) / 5,
        height: 1,
        color: selected ? MyColors.textBlack : Colors.transparent,
      ),
    );
  }
}
