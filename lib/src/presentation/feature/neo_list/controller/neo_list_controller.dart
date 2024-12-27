import 'package:flutter/material.dart';
import 'package:nasa/src/domain/use_case/get_neo_list.dart';
import 'package:nasa/src/presentation/feature/neo_list/state/neo_list_state.dart';

class NeoListController extends ChangeNotifier {
  final GetNeoList getNeoList;

  NeoListController({required this.getNeoList});

  NeoListState _state = NeoListState.initial();
  NeoListState get state => _state;

  Future<void> loadNeos(String startDate, String endDate) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await getNeoList(startDate, endDate);
    result.fold(
      (failure) {
        _state = _state.copyWith(isLoading: false, error: failure.message);
      },
      (neos) {
        _state = _state.copyWith(isLoading: false, neos: neos);
      },
    );

    notifyListeners();
  }
}
