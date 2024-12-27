import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/presentation/feature/apod_list/state/apod_list_state.dart';

class ApodPaginationManager {
  static const int daysToLoad = 15;
  final GetApodList getApodList;

  ApodPaginationManager(this.getApodList);

  Future<Either<Failure, List<Apod>>> fetchInitialData(
    DateTime? oldestLoadedDate,
  ) {
    final endDate = oldestLoadedDate ?? DateTime.now();
    final startDate = endDate.subtract(const Duration(days: daysToLoad));

    return getApodList(startDate, endDate);
  }

  Future<Either<Failure, List<Apod>>> fetchMoreApods(
    DateTime? oldestLoadedDate,
  ) {
    if (oldestLoadedDate == null) return Future.value(const Right([]));

    final endDate = DateTime(
      oldestLoadedDate.year,
      oldestLoadedDate.month,
      oldestLoadedDate.day,
    ).subtract(const Duration(days: 1));

    final startDate = endDate.subtract(const Duration(days: daysToLoad));
    return getApodList(startDate, endDate);
  }

  bool shouldLoadMore(ApodListState state) {
    return !state.isLoading &&
        !state.isLoadingMore &&
        !state.hasReachedEnd &&
        state.searchQuery.isEmpty &&
        state.oldestLoadedDate != null;
  }
}
