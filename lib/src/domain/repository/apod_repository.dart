import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';

abstract class ApodRepository {
  Future<Either<Failure, List<Apod>>> getApodList(
    DateTime startDate,
    DateTime endDate,
  );

  Future<Either<Failure, Apod>> getApodByDate(DateTime date);

  Future<Either<Failure, List<Apod>>> searchApods(String query);

  Future<void> clearCache();
}
