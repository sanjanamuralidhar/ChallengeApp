import 'dart:developer' as developer;
import 'package:ChallengeApp/configs/configs.dart';

class UtilLogger {
  static const String TAG = "ShopLocalTo";

  static log([String tag = TAG, dynamic msg]) {
    if (Application.debug) {
      developer.log('$msg', name: tag);
    }
  }

  static final UtilLogger _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
