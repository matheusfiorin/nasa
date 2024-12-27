import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nasa/src/domain/entity/neo.dart';

part 'neo_list_state.freezed.dart';

@freezed
class NeoListState with _$NeoListState {
  const factory NeoListState({
    required List<Neo> neos,
    required bool isLoading,
    required String error,
  }) = _NeoListState;

  factory NeoListState.initial() => const NeoListState(
        neos: [],
        isLoading: false,
        error: '',
      );
}
