import 'package:nasa/src/domain/repository/apod_repository.dart';

class ClearCache {
  final ApodRepository repository;

  ClearCache(this.repository);

  Future<void> call() async {
    return await repository.clearCache();
  }
}
