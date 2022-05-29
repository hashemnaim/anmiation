import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/my_styles.dart';

//TODO: Core widget?
class MoreButtonLine extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MoreButtonLine(this.text, {@required this.onPressed, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: MyStyles.boldText18,
        ),
        TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(const Size(20, 20))),
          child: Row(
            children: [
              Text(
                'MEHR ',
                style: MyStyles.greyMediumText10,
              ),
              SvgPicture.asset(
                'assets/icons/more-large.svg',
                height: 8,
                color: Colors.grey,
              )
            ],
          ),
          onPressed: onPressed,
        )
      ],
    );
  }
}
