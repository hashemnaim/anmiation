import 'package:flutter/material.dart';

import '../../../theme/my_styles.dart';

class TimePeriodButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double screenWidth;

  const TimePeriodButton({Key key, this.onTap, this.title, this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            //width: (screenWidth - 30) / 5,
            child: Center(
                child: Text(
              title,
              style: MyStyles.normalText12,
            ))),
      ),
    );
  }
}
