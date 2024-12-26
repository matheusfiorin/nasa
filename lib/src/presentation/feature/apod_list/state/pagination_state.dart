class PaginationState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final DateTime? oldestLoadedDate;

  const PaginationState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.oldestLoadedDate,
  });

  PaginationState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    DateTime? oldestLoadedDate,
  }) {
    return PaginationState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      oldestLoadedDate: oldestLoadedDate ?? this.oldestLoadedDate,
    );
  }
}
