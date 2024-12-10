import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';

class GetApodDetail {
  final ApodRepository repository;

  GetApodDetail(this.repository);

  Future<Either<Failure, Apod>> call(DateTime date) {
    return repository.getApodByDate(date);
  }
}
