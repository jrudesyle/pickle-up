enum Environment { development, staging, production }

class Env {
  static Environment current = Environment.development;
  
  static String get apiBaseUrl {
    switch (current) {
      case Environment.development:
        return 'http://localhost:3000';
      case Environment.staging:
        return 'https://staging-api.pickleup.app';
      case Environment.production:
        return 'https://api.pickleup.app';
    }
  }
  
  static bool get isDevelopment => current == Environment.development;
  static bool get isProduction => current == Environment.production;
}
