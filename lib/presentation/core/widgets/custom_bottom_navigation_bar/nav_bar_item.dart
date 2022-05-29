import 'package:equatable/equatable.dart';

import '../../../screens/swipe_screen/swipe_screen.dart';

class NavBarItem extends Equatable {
  final String route;
  final String activeIconPath;
  final String inactiveIconPath;
  final String label;
  final double iconBottomPadding;

  static List<NavBarItem> values = [
    const NavBarItem.Matches(),
    const NavBarItem.Swiping(),
    const NavBarItem.Trending(),
  ];

  const NavBarItem.Matches()
      : route = 'MatchesScreen.url',
        label = 'Matches',
        activeIconPath = 'assets/icons/navigation_bar/matches-active.svg',
        inactiveIconPath = 'assets/icons/navigation_bar/matches-inactive.svg',
        iconBottomPadding = 6.0;
  const NavBarItem.Swiping()
      : route = SwipeScreen.url,
        label = 'Swipe',
        activeIconPath = 'assets/icons/navigation_bar/swipe-active.svg',
        inactiveIconPath = 'assets/icons/navigation_bar/swipe-inactive.svg',
        iconBottomPadding = 11.0;
  const NavBarItem.Trending()
      : route = 'TrendingScreen.url',
        label = 'Trending',
        activeIconPath = 'assets/icons/navigation_bar/trending-active.svg',
        inactiveIconPath = 'assets/icons/navigation_bar/trending-inactive.svg',
        iconBottomPadding = 6.0;

  @override
  List<Object> get props => [label, route];
}
