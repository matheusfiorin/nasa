import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/manager/apod_data_manager.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/manager/apod_pagination_manager.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/manager/apod_scroll_manager.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';
import 'package:nasa/src/presentation/feature/apod_list/state/apod_list_state.dart';

class ApodListController extends ChangeNotifier {
  final GetApodList _getApodList;
  final SearchApods _searchApods;
  final ClearCache _clearCache;

  late final ApodPaginationManager _paginationManager;
  late final ApodDataManager _dataManager;
  late final ApodScrollManager _scrollManager;

  ApodListController({
    required GetApodList getApodList,
    required SearchApods searchApods,
    required ClearCache clearCache,
  })  : _getApodList = getApodList,
        _searchApods = searchApods,
        _clearCache = clearCache {
    _initializeManagers();
  }

  void _initializeManagers() {
    _paginationManager = ApodPaginationManager(_getApodList);
    _dataManager = ApodDataManager();
    _scrollManager = ApodScrollManager(onLoadMore: loadMore);
    _scrollManager.init();
  }

  ApodListState _state = const ApodListState();
  ApodListState get state => _state;
  ScrollController get scrollController => _scrollManager.scrollController;

  List<ApodUiModel> get uiModels =>
      _dataManager.convertToUiModels(_state.apods);

  // MARK: - Public Methods

  Future<void> loadApods({bool refresh = false}) async {
    if (_state.isLoading) return;

    if (refresh) {
      await _resetState();
    }

    await _loadInitialData();
  }

  Future<void> loadMore() async {
    if (!_paginationManager.shouldLoadMore(_state)) return;

    await _handlePagination();
  }

  Future<void> searchApodsList(String query) async {
    _updateState((s) => s.copyWith(searchQuery: query));

    if (query.isEmpty) {
      return _handleEmptySearch();
    }

    await _performSearch(query);
  }

  Future<void> refresh() => loadApods(refresh: true);

  // MARK: - Private Methods - Data Loading

  Future<void> _loadInitialData() async {
    _updateLoadingState(true);

    try {
      final result =
          await _paginationManager.fetchInitialData(_state.oldestLoadedDate);
      _handleDataResult(result);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  Future<void> _handlePagination() async {
    _updateState((s) => s.copyWith(isLoadingMore: true));

    try {
      final result =
          await _paginationManager.fetchMoreApods(_state.oldestLoadedDate);
      _handlePaginationResult(result);
    } catch (e) {
      _handleError(e.toString(), isPagination: true);
    }
  }

  Future<void> _performSearch(String query) async {
    _updateLoadingState(true);

    try {
      final result = await _searchApods(query);
      _handleSearchResult(result);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  // MARK: - Private Methods - State Updates

  void _updateState(ApodListState Function(ApodListState) update) {
    _state = update(_state);
    notifyListeners();
  }

  void _updateLoadingState(bool isLoading) {
    _updateState((s) => s.copyWith(
          isLoading: isLoading,
          error: '',
        ));
  }

  Future<void> _resetState() async {
    await _clearCache();
    _updateState((s) => const ApodListState());
  }

  Future<void> _handleEmptySearch() async {
    await _resetState();
    return loadApods();
  }

  // MARK: - Private Methods - Result Handling

  void _handleDataResult(Either<Failure, List<Apod>> result) {
    result.fold(
      (failure) => _handleError(failure.message),
      (newApods) => _processNewApods(newApods),
    );
  }

  void _handlePaginationResult(Either<Failure, List<Apod>> result) {
    result.fold(
      (failure) => _handleError(failure.message, isPagination: true),
      (newApods) => _processMoreApods(newApods),
    );
  }

  void _handleSearchResult(Either<Failure, List<Apod>> result) {
    result.fold(
      (failure) => _handleError(failure.message),
      (apods) => _updateState((s) => s.copyWith(
            apods: apods,
            isLoading: false,
          )),
    );
  }

  void _processNewApods(List<Apod> newApods) {
    if (newApods.isEmpty) {
      _updateState((s) => s.copyWith(
            hasReachedEnd: true,
            isLoading: false,
          ));
    } else {
      final uniqueApods = _dataManager.getUniqueApods(
        [..._state.apods, ...newApods],
      );
      _updateState((s) => s.copyWith(
            apods: uniqueApods,
            oldestLoadedDate: _dataManager.getOldestDate(newApods),
            isLoading: false,
          ));
    }
  }

  void _processMoreApods(List<Apod> newApods) {
    if (newApods.isEmpty) {
      _updateState((s) => s.copyWith(
            isLoadingMore: false,
            hasReachedEnd: true,
          ));
    } else {
      final uniqueApods = _dataManager.getUniqueApods(
        [..._state.apods, ...newApods],
      );
      _updateState((s) => s.copyWith(
            apods: uniqueApods,
            oldestLoadedDate: _dataManager.getOldestDate(uniqueApods),
            isLoadingMore: false,
          ));
    }
  }

  void _handleError(String error, {bool isPagination = false}) {
    _updateState((s) => s.copyWith(
          error: error,
          isLoading: false,
          isLoadingMore: isPagination ? false : s.isLoadingMore,
          hasReachedEnd: isPagination ? true : s.hasReachedEnd,
        ));
  }

  @override
  void dispose() {
    _scrollManager.dispose();
    super.dispose();
  }
}
