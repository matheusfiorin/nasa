import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';

class SearchApods {
  final ApodRepository repository;

  SearchApods(this.repository);

  Future<Either<Failure, List<Apod>>> call(String query) {
    return repository.searchApods(query);
  }
}
