import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/provider/local/apod_local_provider.dart';
import 'package:nasa/src/data/provider/remote/apod_remote_provider.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteProvider remoteProvider;
  final ApodLocalProvider localProvider;
  final NetworkInfo networkInfo;

  ApodRepositoryImpl({
    required this.remoteProvider,
    required this.localProvider,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Apod>>> getApodList(
      DateTime startDate, DateTime endDate) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteApods = await remoteProvider.getApodList(
          DateFormat('yyyy-MM-dd').format(startDate),
          DateFormat('yyyy-MM-dd').format(endDate),
        );
        await localProvider.cacheApodList(
          remoteApods.map((apod) => ApodHiveModel.fromApod(apod)).toList(),
        );
        return Right(remoteApods);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      try {
        final localApods = await localProvider.getApodList();
        return Right(localApods.map((model) => model.toEntity()).toList());
      } on CacheException {
        return const Left(CacheFailure('No cached data found'));
      }
    }
  }

  @override
  Future<Either<Failure, Apod>> getApodByDate(DateTime date) async {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    if (await networkInfo.isConnected) {
      try {
        final remoteApod = await remoteProvider.getApodByDate(dateStr);
        await localProvider.cacheApod(ApodHiveModel.fromApod(remoteApod));
        return Right(remoteApod);
      } on ServerException {
        return const Left(ServerFailure('Failed to fetch data from server'));
      }
    } else {
      try {
        final localApod = await localProvider.getApodByDate(dateStr);
        return Right(localApod!.toEntity());
      } on CacheException {
        return const Left(CacheFailure('No cached data found'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Apod>>> searchApods(String query) async {
    try {
      final localApods = await localProvider.getApodList();
      final filteredApods = localApods
          .map((model) => model.toEntity())
          .where((apod) =>
              apod.title.toLowerCase().contains(query.toLowerCase()) ||
              apod.date.contains(query))
          .toList();
      return Right(filteredApods);
    } on CacheException {
      return const Left(CacheFailure('No cached data found'));
    }
  }
}
