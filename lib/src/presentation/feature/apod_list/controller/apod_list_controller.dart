import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';

class ApodListController extends ChangeNotifier {
  final GetApodList getApodList;
  final SearchApods searchApods;
  final ClearCache clearCache;

  ApodListController({
    required this.getApodList,
    required this.searchApods,
    required this.clearCache,
  });

  List<Apod> _apods = [];

  List<Apod> get apods => _apods;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  String _error = '';

  String get error => _error;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  bool _hasReachedEnd = false;

  bool get hasReachedEnd => _hasReachedEnd;

  DateTime? _oldestLoadedDate;

  Future<void> loadApods({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _oldestLoadedDate = null;
      _hasReachedEnd = false;
      _apods.clear();
      await clearCache();
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    final endDate = _oldestLoadedDate ?? DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 15));

    final result = await getApodList(startDate, endDate);

    result.fold(
          (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
          (newApods) {
        if (newApods.isEmpty) {
          _hasReachedEnd = true;
        } else {
          _apods.addAll(newApods);
          _apods.sort((a, b) => b.date.compareTo(a.date));
          _oldestLoadedDate = startDate;
        }
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoading ||
        _isLoadingMore ||
        _hasReachedEnd ||
        _searchQuery.isNotEmpty) {
      return;
    }

    if (_oldestLoadedDate == null) {
      _isLoadingMore = false;
      notifyListeners();
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    try {
      final endDate = DateTime(_oldestLoadedDate!.year,
          _oldestLoadedDate!.month, _oldestLoadedDate!.day)
          .subtract(const Duration(days: 1));
      final startDate = endDate.subtract(const Duration(days: 15));

      final result = await getApodList(startDate, endDate);

      result.fold(
            (failure) {
          _error = failure.message;
          _isLoadingMore = false;
          notifyListeners();
        },
            (newApods) {
          if (newApods.isEmpty) {
            _hasReachedEnd = true;
          } else {
            final uniqueApods = Map<String, Apod>.fromEntries([
              ..._apods,
              ...newApods
            ].map((apod) => MapEntry(apod.date, apod))).values.toList()
              ..sort((a, b) => b.date.compareTo(a.date));

            _apods = uniqueApods;
            _oldestLoadedDate = DateTime.parse(_apods
                .map((a) => a.date)
                .reduce((a, b) => a.compareTo(b) < 0 ? a : b));
          }
          _isLoadingMore = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _error = e.toString();
      _isLoadingMore = false;
      _hasReachedEnd = true;
      notifyListeners();
    }
  }

  Future<void> searchApodsList(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _apods.clear();
      _oldestLoadedDate = null;
      _hasReachedEnd = false;
      await loadApods();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await searchApods(query);

    result.fold(
          (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
          (apods) {
        _apods = apods;
        _apods.sort((a, b) => b.date.compareTo(a.date));
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    await loadApods(refresh: true);
  }
}
