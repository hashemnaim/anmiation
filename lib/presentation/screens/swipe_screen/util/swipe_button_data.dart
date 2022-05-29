import 'package:flutter/foundation.dart';

class SwipeButtonBehavior {
  final bool showButtons;

  /// {@template onlike}
  /// Alternate callback for non-swipe-screens.
  ///
  /// If no [onLike] and [onDislike] is passed, the default behavior is to call the [SwipeCubit.onSwiped] method.
  /// {@endtemplate}
  final VoidCallback onLike;

  /// {@macro onlike}
  final VoidCallback onDislike;

  SwipeButtonBehavior({this.showButtons = true, this.onLike, this.onDislike})
      : assert(!showButtons || onLike != null && onDislike != null,
            "If you show the swipe buttons, you should pass data for it.");
}
