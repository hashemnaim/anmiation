import 'dart:async';

import 'package:flutter/foundation.dart';

/// A debouncer to stop functions from mass executing.
///
/// Useful when a user types something into a search but you don't want to send a request for each letter.
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  void run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
