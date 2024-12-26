import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nasa/src/domain/entity/apod.dart';

part 'apod_list_state.freezed.dart';

@freezed
class ApodListState with _$ApodListState {
  const factory ApodListState({
    @Default([]) List<Apod> apods,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    @Default('') String error,
    @Default('') String searchQuery,
    DateTime? oldestLoadedDate,
  }) = _ApodListState;
}
