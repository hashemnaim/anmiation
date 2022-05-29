import 'package:flutter/material.dart';

void dismissKeyboard([BuildContext context]) {
  if (context == null) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    return;
  }

  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!(currentFocus?.hasPrimaryFocus ?? true)) {
    currentFocus.unfocus();
  }
}
