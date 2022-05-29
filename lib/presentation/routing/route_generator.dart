import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vario/presentation/screens/onboarding_chat_screen/onboarding_chat_screen.dart';

import '../screens/swipe_screen/swipe_screen.dart';

import 'model/routing_data.dart';

import 'string_extensions.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    RoutingData routingData;
    try {
      routingData = settings.name.getRoutingData;
    } catch (e) {
      debugPrint(e);
    }

    switch (routingData.route) {
     
      case OnboardingChatScreen.route:
        return _getPageRoute(OnboardingChatScreen(), settings);
   
      case SwipeScreen.url:
        return _getPageRoute(SwipeScreen(), settings);
   
      default:
        // should display an error screen etc.
        // return kIsWeb ? _getPageRoute(const StartScreen(), settings) : null;
        return null;
    }
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return FadeRoute(child: child, routeName: settings.name);
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
