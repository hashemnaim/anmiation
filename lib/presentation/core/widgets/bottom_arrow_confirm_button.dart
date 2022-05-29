import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/my_colors.dart';
import '../theme/my_styles.dart';

class BottomArrowConfirmButton extends StatelessWidget {
  /// Optional label on the button.
  ///
  /// If null, the arrow will be displayed instead.
  final String label;
  final VoidCallback onTap;
  final bool active;
  final double width;

  const BottomArrowConfirmButton(
      {Key key,
      this.label,
      this.width = 150,
      @required this.onTap,
      this.active = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: active
            ? MyColors.constMainGreen
            : MyColors.constMainGreen.withOpacity(0.5),
      ),
      width: width,
      height: 55,
      child: InkWell(
        onTap: active ? () => onTap() : null,
        child: Center(
          child: label != null
              ? Text(
                  label,
                  style: MyStyles.normalText16.copyWith(color: Colors.white),
                )
              : SvgPicture.asset(
                  'assets/icons/next.svg',
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
