class ApiConfig {
  static const String baseUrl = 'https://api.nasa.gov/planetary/apod';
  static const String apiKey = 'DEMO_KEY';

  static const int itemsPerPage = 10;

  // API Endpoints
  static String getApodList(String startDate, String endDate) {
    return '$baseUrl?api_key=$apiKey&start_date=$startDate&end_date=$endDate';
  }

  static String searchApod(String date) {
    return '$baseUrl?api_key=$apiKey&date=$date';
  }
}