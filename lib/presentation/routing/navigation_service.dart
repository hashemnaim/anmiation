import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/swipe_screen/cubit/swipe_cubit.dart';
import '../screens/swipe_screen/swipe_screen.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams,
      Object arguments,
      bool pushReplace = false,
      bool removeAll = false}) {
    assert(!pushReplace || !removeAll);

    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    if (pushReplace) {
      return navigationKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);
    } else if (removeAll) {
      return navigationKey.currentState.pushNamedAndRemoveUntil(
          routeName, (route) => false,
          arguments: arguments);
    } else {
      return navigationKey.currentState
          .pushNamed(routeName, arguments: arguments);
    }
  }

  bool goBack() {
    navigationKey.currentState.pop();
    return true;
  }

  void goBackToScreen(String newRouteName) {
    navigationKey.currentState.popUntil(ModalRoute.withName(newRouteName));
  }

  void navigateAndPreloadSwipeScreen(BuildContext context) {
    context.read<SwipeCubit>().fetchNextInvestments(initialLoad: true);
    navigateTo(SwipeScreen.url, removeAll: true);
  }
}
