import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/neo.dart';
import 'package:nasa/src/domain/repository/neo_repository.dart';

class GetNeoList {
  final NeoRepository repository;

  GetNeoList(this.repository);

  Future<Either<Failure, List<Neo>>> call(String startDate, String endDate) {
    return repository.getNeoList(startDate, endDate);
  }
}
