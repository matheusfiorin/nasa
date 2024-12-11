import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/core/utils/formatter.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/repository/contracts/apod_local_provider.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';
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
    try {
      final localApods = await localProvider.getApodList();
      final filteredLocalApods =
          localApods.map((model) => model.toEntity()).where((apod) {
        final apodDate = DateFormat('yyyy-MM-dd').parse(apod.date);
        return apodDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
            apodDate.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();

      if (filteredLocalApods.isNotEmpty) {
        return Right(filteredLocalApods);
      }
    } catch (e) {
      // If local fetch fails, we'll continue to try remote
    }

    if (await networkInfo.isConnected) {
      try {
        final remoteApods = await remoteProvider.getApodList(
          Formatter.date(startDate),
          Formatter.date(endDate),
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
      return const Left(
        CacheFailure('No cached data found and no internet connection'),
      );
    }
  }

  @override
  Future<Either<Failure, Apod>> getApodByDate(DateTime date) async {
    final dateStr = Formatter.date(date);
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

  @override
  Future<void> clearCache() async {
    try {
      await localProvider.clearCache();
    } on CacheException {
      throw const CacheFailure('Failed to clear cache');
    }
  }
}
