import 'package:flutter/foundation.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/presentation/feature/apod_list/state/pagination_state.dart';

class PaginationController extends ChangeNotifier {
  final GetApodList getApodList;
  static const int daysToLoad = 15;

  PaginationState _state = const PaginationState();

  PaginationState get state => _state;

  PaginationController({required this.getApodList});

  Future<List<Apod>> loadPage() async {
    if (_state.isLoading || _state.hasReachedEnd) return [];

    _updateState((s) => s.copyWith(isLoading: true));

    try {
      final endDate = _state.oldestLoadedDate ?? DateTime.now();
      final startDate = endDate.subtract(const Duration(days: daysToLoad));

      final result = await getApodList(startDate, endDate);

      return result.fold(
        (failure) {
          _updateState((s) => s.copyWith(
                hasReachedEnd: true,
                isLoading: false,
              ));
          return [];
        },
        (apods) {
          if (apods.isEmpty) {
            _updateState((s) => s.copyWith(
                  hasReachedEnd: true,
                  isLoading: false,
                ));
            return [];
          }

          // Sort DESC and get the oldest date for next pagination
          final sortedApods = apods..sort((a, b) => b.date.compareTo(a.date));
          if (sortedApods.isNotEmpty) {
            final oldestDate = DateTime.parse(sortedApods.last.date).subtract(
                const Duration(days: 1)); // Subtract 1 day to avoid duplicates

            _updateState((s) => s.copyWith(
                  oldestLoadedDate: oldestDate,
                  isLoading: false,
                ));
          }

          return sortedApods;
        },
      );
    } catch (e) {
      _updateState((s) => s.copyWith(
            hasReachedEnd: true,
            isLoading: false,
          ));
      return [];
    }
  }

  void reset() {
    _state = const PaginationState();
    notifyListeners();
  }

  void _updateState(PaginationState Function(PaginationState) update) {
    _state = update(_state);
    notifyListeners();
  }
}
