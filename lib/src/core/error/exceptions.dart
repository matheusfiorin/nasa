class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server Error']);

  @override
  String toString() => message;
}

class CacheException implements Exception {}