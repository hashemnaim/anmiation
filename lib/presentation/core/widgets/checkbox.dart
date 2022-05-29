import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/my_colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(this.isChecked,
      {Key key, @required this.onChanged, this.size = 20})
      : super(key: key);

  final bool isChecked;
  final void Function(bool) onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onChanged(!isChecked);
        },
        child: Container(
          child: isChecked
              ? Center(
                  child: SvgPicture.asset(
                  'assets/icons/checkmark.svg',
                  color: Colors.white,
                ))
              : null,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isChecked ? MyColors.constMainGreen : Colors.transparent,
            border: Border.all(color: MyColors.borderGrey),
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
