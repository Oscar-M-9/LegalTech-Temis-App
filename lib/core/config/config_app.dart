import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigApp {
  ConfigApp._();
  static final String apiBaseUrl =
      dotenv.env['API_BASE_URL'] ?? "https://api.temisperu.com";
  static final bool isProduction = dotenv.env['IS_PRODUCTION'] == "true";
}
