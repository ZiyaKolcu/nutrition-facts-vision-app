import 'package:flutter/foundation.dart';

const String apiBaseOverride = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: '',
);

String getApiBase() {
  if (apiBaseOverride.isNotEmpty) {
    return apiBaseOverride;
  }
  if (kIsWeb) return 'http://localhost:8000/api/v1';
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:8000/api/v1';
    default:
      return 'http://localhost:8000/api/v1';
  }
}
