import 'package:flutter/material.dart';

import '../theme/my_colors.dart';
import '../theme/my_styles.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {Key key, @required this.onPressed, @required this.label})
      : super(key: key);
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width * ((414 - 40) / 414),
      child: FloatingActionButton.extended(
        elevation: 0,
        onPressed: onPressed,
        backgroundColor: MyColors.constMainGreen,
        label: Text(label, style: MyStyles.mediumWhiteText15),
      ),
    );
  }
}
