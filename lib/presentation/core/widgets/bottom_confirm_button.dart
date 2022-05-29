import 'package:flutter/material.dart';

import '../theme/my_colors.dart';
import '../theme/my_styles.dart';

class BottomConfirmButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const BottomConfirmButton(this.text, {@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyColors.constMainGreen,
          boxShadow: [
            BoxShadow(
              color: MyColors.mainGreen.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ]),
      width: double.infinity,
      height: 55,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(text, style: MyStyles.mediumWhiteText15),
        ),
      ),
    );
  }
}
