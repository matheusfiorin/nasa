import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = 'https://api.nasa.gov/planetary/apod';
  static const String baseNeoUrl =
      'https://go-rest-api-production-f357.up.railway.app/neo';

  static String get apiKey => dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  // API Endpoints
  static String getApodListUri(String startDate, String endDate) {
    return '$baseUrl?api_key=$apiKey&start_date=$startDate&end_date=$endDate';
  }

  static String searchApodUri(String date) {
    return '$baseUrl?api_key=$apiKey&date=$date';
  }
}
