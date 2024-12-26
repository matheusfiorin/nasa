import 'package:flutter/material.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/presentation/feature/apod_list/state/apod_list_state.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodListController extends ChangeNotifier {
  final GetApodList _getApodList;
  final SearchApods _searchApods;
  final ClearCache _clearCache;
  static const int _daysToLoad = 15;

  ApodListController({
    required GetApodList getApodList,
    required SearchApods searchApods,
    required ClearCache clearCache,
  })  : _getApodList = getApodList,
        _searchApods = searchApods,
        _clearCache = clearCache,
        scrollController = ScrollController() {
    scrollController.addListener(_onScroll);
  }

  final ScrollController scrollController;
  ApodListState _state = const ApodListState();

  ApodListState get state => _state;

  void _updateState(ApodListState Function(ApodListState) update) {
    _state = update(_state);
    notifyListeners();
  }

  Future<void> loadApods({bool refresh = false}) async {
    if (_state.isLoading) return;

    if (refresh) {
      await _resetState();
    }

    _updateState(
      (s) => s.copyWith(
        isLoading: true,
        error: '',
      ),
    );

    try {
      final endDate = _state.oldestLoadedDate ?? DateTime.now();
      final startDate = endDate.subtract(const Duration(days: _daysToLoad));

      final result = await _getApodList(startDate, endDate);

      result.fold(
        (failure) => _updateState(
          (s) => s.copyWith(
            error: failure.message,
            isLoading: false,
          ),
        ),
        (newApods) => _handleNewApods(newApods, startDate),
      );
    } catch (e) {
      _handleError(e.toString());
    }
  }

  Future<void> loadMore() async {
    if (_shouldSkipLoadMore) return;

    _updateState((s) => s.copyWith(isLoadingMore: true));

    try {
      final result = await _fetchMoreApods();
      result.fold(
        (failure) => _updateState(
          (s) => s.copyWith(
            error: failure.message,
            isLoadingMore: false,
          ),
        ),
        (newApods) => _processMoreApods(newApods),
      );
    } catch (e) {
      _handleLoadMoreError(e.toString());
    }
  }

  Future<void> searchApodsList(String query) async {
    _updateState((s) => s.copyWith(searchQuery: query));

    if (query.isEmpty) {
      await _resetState();
      return await loadApods();
    }

    _updateState(
      (s) => s.copyWith(
        isLoading: true,
        error: '',
      ),
    );

    try {
      final result = await _searchApods(query);
      result.fold(
        (failure) => _updateState(
          (s) => s.copyWith(
            error: failure.message,
            isLoading: false,
          ),
        ),
        (apods) => _updateState(
          (s) => s.copyWith(
            apods: apods,
            isLoading: false,
          ),
        ),
      );
    } catch (e) {
      _handleError(e.toString());
    }
  }

  Future<void> refresh() => loadApods(refresh: true);

  // Private helper methods
  bool get _shouldSkipLoadMore =>
      _state.isLoading ||
      _state.isLoadingMore ||
      _state.hasReachedEnd ||
      _state.searchQuery.isNotEmpty ||
      _state.oldestLoadedDate == null;

  Future<void> _resetState() async {
    await _clearCache();
    _updateState((s) => const ApodListState());
  }

  void _handleNewApods(List<Apod> newApods, DateTime startDate) {
    if (newApods.isEmpty) {
      _updateState(
        (s) => s.copyWith(
          hasReachedEnd: true,
          isLoading: false,
        ),
      );
    } else {
      _updateState(
        (s) => s.copyWith(
          apods: [...s.apods, ...newApods],
          oldestLoadedDate: startDate,
          isLoading: false,
        ),
      );
    }
  }

  void _handleError(String error) {
    _updateState(
      (s) => s.copyWith(
        error: error,
        isLoading: false,
      ),
    );
  }

  void _handleLoadMoreError(String error) {
    _updateState(
      (s) => s.copyWith(
        error: error,
        isLoadingMore: false,
        hasReachedEnd: true,
      ),
    );
  }

  Future<Either<Failure, List<Apod>>> _fetchMoreApods() async {
    final endDate = DateTime(
      _state.oldestLoadedDate!.year,
      _state.oldestLoadedDate!.month,
      _state.oldestLoadedDate!.day,
    ).subtract(const Duration(days: 1));
    final startDate = endDate.subtract(const Duration(days: _daysToLoad));

    return _getApodList(startDate, endDate);
  }

  void _processMoreApods(List<Apod> newApods) {
    if (newApods.isEmpty) {
      _updateState(
        (s) => s.copyWith(
          isLoadingMore: false,
          hasReachedEnd: true,
        ),
      );
    } else {
      final uniqueApods = _getUniqueApods([..._state.apods, ...newApods]);
      _updateState(
        (s) => s.copyWith(
          apods: uniqueApods,
          oldestLoadedDate: DateTime.parse(uniqueApods.last.date),
          isLoadingMore: false,
        ),
      );
    }
  }

  List<Apod> _sortApods(List<Apod> apods) {
    return List<Apod>.from(apods)..sort((a, b) => b.date.compareTo(a.date));
  }

  List<Apod> _getUniqueApods(List<Apod> apods) {
    return _sortApods(
      Map<String, Apod>.fromEntries(
        apods.map((apod) => MapEntry(apod.date, apod)),
      ).values.toList(),
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      loadMore();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
