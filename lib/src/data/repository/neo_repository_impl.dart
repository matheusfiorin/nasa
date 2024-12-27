import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/data/provider/remote/neo_remote_provider.dart';
import 'package:nasa/src/domain/entity/neo.dart';
import 'package:nasa/src/domain/repository/neo_repository.dart';

class NeoRepositoryImpl implements NeoRepository {
  final NeoRemoteProvider remoteProvider;

  NeoRepositoryImpl({required this.remoteProvider});

  @override
  Future<Either<Failure, List<Neo>>> getNeoList(
    String startDate,
    String endDate,
  ) async {
    try {
      final neos = await remoteProvider.getNeoList(startDate, endDate);
      return Right(neos);
    } on ServerException {
      return const Left(ServerFailure('Failed to fetch NEO list'));
    }
  }
}
