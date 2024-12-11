import 'package:nasa/src/domain/entity/apod.dart';

class ApodListState {
  final List<Apod> apods;
  final bool isLoading;
  final bool isLoadingMore;
  final String error;
  final String searchQuery;
  final bool hasReachedEnd;
  final DateTime? oldestLoadedDate;

  const ApodListState({
    this.apods = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error = '',
    this.searchQuery = '',
    this.hasReachedEnd = false,
    this.oldestLoadedDate,
  });

  ApodListState copyWith({
    List<Apod>? apods,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? searchQuery,
    bool? hasReachedEnd,
    DateTime? oldestLoadedDate,
  }) {
    return ApodListState(
      apods: apods ?? this.apods,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      oldestLoadedDate: oldestLoadedDate ?? this.oldestLoadedDate,
    );
  }
}