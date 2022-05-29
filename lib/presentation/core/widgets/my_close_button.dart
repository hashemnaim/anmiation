import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../locator.dart';
import '../../routing/navigation_service.dart';
import '../theme/my_colors.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: () => locator<NavigationService>().goBack(),
        child: Container(
            width: 28,
            height: 28,
            child: Material(
              color: Colors.white,
              child: IconButton(
                  icon: SvgPicture.asset('assets/icons/close.svg'),
                  color: MyColors.grey,
                  padding: const EdgeInsets.all(0),
                  onPressed: () => locator<NavigationService>().goBack()),
            )),
      ),
      right: 16,
      top: 20,
    );
  }
}
