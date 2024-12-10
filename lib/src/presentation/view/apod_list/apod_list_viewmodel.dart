import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';

class ApodListViewModel extends ChangeNotifier {
  final GetApodList getApodList;
  final SearchApods searchApods;

  ApodListViewModel({
    required this.getApodList,
    required this.searchApods,
  });

  List<Apod> _apods = [];

  List<Apod> get apods => _apods;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _error = '';

  String get error => _error;

  Future<void> loadApods() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));

    final result = await getApodList(startDate, endDate);

    result.fold(
      (failure) {
        _error = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (apods) {
        _apods = apods;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> searchApodsList(String query) async {
    if (query.isEmpty) {
      loadApods();
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
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    await loadApods();
  }
}
