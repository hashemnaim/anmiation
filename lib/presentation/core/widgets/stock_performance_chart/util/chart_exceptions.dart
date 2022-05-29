import 'package:flutter/foundation.dart';

class NotEnoughDataException extends Error {
  NotEnoughDataException(String errorMessage) {
    debugPrint(errorMessage);
  }
}
