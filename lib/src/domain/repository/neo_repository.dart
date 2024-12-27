import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/neo.dart';

abstract class NeoRepository {
  Future<Either<Failure, List<Neo>>> getNeoList(
      String startDate, String endDate);
}
