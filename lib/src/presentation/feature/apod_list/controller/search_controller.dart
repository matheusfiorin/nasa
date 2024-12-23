import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';

class ApodSearchController extends ChangeNotifier {
  final SearchApods searchApods;
  String _query = '';
  bool _isSearching = false;

  String get query => _query;

  bool get isSearching => _isSearching;

  ApodSearchController({required this.searchApods});

  Future<List<Apod>> search(String query) async {
    _query = query;
    _isSearching = query.isNotEmpty;
    notifyListeners();

    if (!_isSearching) return [];

    final result = await searchApods(query);
    return result.fold(
      (failure) => [],
      (apods) => apods,
    );
  }

  void reset() {
    _query = '';
    _isSearching = false;
    notifyListeners();
  }
}
