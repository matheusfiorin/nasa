import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';

class GetApodList {
  final ApodRepository repository;

  GetApodList(this.repository);

  Future<Either<Failure, List<Apod>>> call(
    DateTime startDate,
    DateTime endDate,
  ) {
    return repository.getApodList(startDate, endDate);
  }
}
