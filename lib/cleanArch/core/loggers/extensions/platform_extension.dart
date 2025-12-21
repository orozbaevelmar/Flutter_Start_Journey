import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformExtensions {
  PlatformExtensions._();

  static final bool isAndroid = !kIsWeb && Platform.isAndroid;

  static final bool isIOS = !kIsWeb && Platform.isIOS;

  static const bool isWeb = kIsWeb;

  static final String localeName = isWeb ? 'en' : Platform.localeName;
}
