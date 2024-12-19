import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/error_handler.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/core/utils/formatter.dart';
import 'package:nasa/src/data/filter/apod_filter.dart';
import 'package:nasa/src/data/mapper/apod_mapper.dart';
import 'package:nasa/src/data/repository/contracts/apod_local_provider.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/repository/apod_repository.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteProvider _remoteProvider;
  final ApodLocalProvider _localProvider;
  final NetworkInfo _networkInfo;

  ApodRepositoryImpl({
    required ApodRemoteProvider remoteProvider,
    required ApodLocalProvider localProvider,
    required NetworkInfo networkInfo,
  })
      : _remoteProvider = remoteProvider,
        _localProvider = localProvider,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Apod>>> getApodList(DateTime startDate,
      DateTime endDate,) async {
    // Try to get from local storage first
    try {
      final localApods = await _localProvider.getApodList();
      final entities = ApodMapper.toEntityList(localApods);
      final filteredApods =
      ApodFilter.byDateRange(entities, startDate, endDate);

      if (filteredApods.isNotEmpty) {
        return Right(filteredApods);
      }
    } catch (_) {
      // Continue to remote if local fails
    }

    // Get from remote if necessary
    if (await _networkInfo.isConnected) {
      return ErrorHandler.handleRepositoryCall(
        call: () async {
          final remoteApods = await _remoteProvider.getApodList(
            Formatter.date(startDate),
            Formatter.date(endDate),
          );

          await _localProvider.cacheApodList(
            ApodMapper.toHiveModelList(remoteApods),
          );

          return remoteApods;
        },
        serverErrorMessage: 'Failed to fetch APOD list from server',
      );
    }

    return const Left(
      CacheFailure('No cached data found and no internet connection'),
    );
  }

  @override
  Future<Either<Failure, Apod>> getApodByDate(DateTime date) async {
    final dateStr = Formatter.date(date);

    if (await _networkInfo.isConnected) {
      return ErrorHandler.handleRepositoryCall(
        call: () async {
          final remoteApod = await _remoteProvider.getApodByDate(dateStr);
          await _localProvider.cacheApod(ApodMapper.toHiveModel(remoteApod));
          return remoteApod;
        },
        serverErrorMessage: 'Failed to fetch APOD for date: $dateStr',
      );
    }

    return ErrorHandler.handleRepositoryCall(
      call: () async {
        final localApod = await _localProvider.getApodByDate(dateStr);
        return ApodMapper.toEntity(localApod!);
      },
      cacheErrorMessage: 'No cached data found for date: $dateStr',
    );
  }

  @override
  Future<Either<Failure, List<Apod>>> searchApods(String query) {
    return ErrorHandler.handleRepositoryCall(
      call: () async {
        final localApods = await _localProvider.getApodList();
        final entities = ApodMapper.toEntityList(localApods);
        return ApodFilter.bySearchQuery(entities, query);
      },
      cacheErrorMessage: 'Failed to search cached APODs',
    );
  }

  @override
  Future<void> clearCache() async {
    try {
      await _localProvider.clearCache();
    } on CacheException {
      throw const CacheFailure('Failed to clear cache');
    }
  }
}
