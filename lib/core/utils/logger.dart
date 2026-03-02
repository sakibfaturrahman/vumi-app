import 'package:flutter/foundation.dart';

class VumiLogger {
  static void log(String message, {Object? error}) {
    if (kDebugMode) {
      print("===== VUMI LOG: $message =====");
      if (error != null) print("ERROR: $error");
    }
  }
}
