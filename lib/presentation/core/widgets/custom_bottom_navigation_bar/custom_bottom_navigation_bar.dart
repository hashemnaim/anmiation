import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../routing/navigation_service.dart';
import '../../theme/my_colors.dart';
import '../flushbar.dart';
import '../svg.dart';
import 'nav_bar_item.dart';

export 'nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(this.selectedItem, {Key key})
      : super(key: key);

  final NavBarItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final int currentIndex = NavBarItem.values.indexOf(selectedItem);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: NavBarItem.values
          .map((e) => BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: e.iconBottomPadding),
                  child: PlatformSvg.asset(e.inactiveIconPath,
                      color: MyColors.grey),
                ),
                activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: e.iconBottomPadding),
                    child: PlatformSvg.asset(e.activeIconPath,
                        color: MyColors.constDarkGrey)),
                label: e.label,
              ))
          .toList(),
      onTap: (index) {
        showErrorBar(context, 'In der Hauptversion implementiert :)');
        // locator<NavigationService>()
        //     .navigateTo(NavBarItem.values[index].route, removeAll: true);
      },
    );
  }
}
