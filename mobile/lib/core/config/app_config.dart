class AppConfig {
  static const String appName = 'PickleUp';
  static const String appVersion = '0.1.0';
  
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:3000';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  
  // Map Configuration
  static const double defaultLatitude = 37.7749; // San Francisco
  static const double defaultLongitude = -122.4194;
  static const double defaultZoom = 13.0;
  static const double nearbyCourtRadius = 10.0; // km
  
  // Check-in Configuration
  static const int checkinDurationMinutes = 120;
  static const double checkinMaxDistance = 0.5; // km
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Feature Flags
  static const bool enableNotifications = true;
  static const bool enableGoogleMaps = true;
  static const bool enableSocialLogin = false;
}
