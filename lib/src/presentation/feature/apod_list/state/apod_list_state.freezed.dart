// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApodListState {
  List<Apod> get apods => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasReachedEnd => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  DateTime? get oldestLoadedDate => throw _privateConstructorUsedError;

  /// Create a copy of ApodListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApodListStateCopyWith<ApodListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApodListStateCopyWith<$Res> {
  factory $ApodListStateCopyWith(
          ApodListState value, $Res Function(ApodListState) then) =
      _$ApodListStateCopyWithImpl<$Res, ApodListState>;
  @useResult
  $Res call(
      {List<Apod> apods,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String error,
      String searchQuery,
      DateTime? oldestLoadedDate});
}

/// @nodoc
class _$ApodListStateCopyWithImpl<$Res, $Val extends ApodListState>
    implements $ApodListStateCopyWith<$Res> {
  _$ApodListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApodListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apods = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = null,
    Object? searchQuery = null,
    Object? oldestLoadedDate = freezed,
  }) {
    return _then(_value.copyWith(
      apods: null == apods
          ? _value.apods
          : apods // ignore: cast_nullable_to_non_nullable
              as List<Apod>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedEnd: null == hasReachedEnd
          ? _value.hasReachedEnd
          : hasReachedEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      oldestLoadedDate: freezed == oldestLoadedDate
          ? _value.oldestLoadedDate
          : oldestLoadedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApodListStateImplCopyWith<$Res>
    implements $ApodListStateCopyWith<$Res> {
  factory _$$ApodListStateImplCopyWith(
          _$ApodListStateImpl value, $Res Function(_$ApodListStateImpl) then) =
      __$$ApodListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Apod> apods,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String error,
      String searchQuery,
      DateTime? oldestLoadedDate});
}

/// @nodoc
class __$$ApodListStateImplCopyWithImpl<$Res>
    extends _$ApodListStateCopyWithImpl<$Res, _$ApodListStateImpl>
    implements _$$ApodListStateImplCopyWith<$Res> {
  __$$ApodListStateImplCopyWithImpl(
      _$ApodListStateImpl _value, $Res Function(_$ApodListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApodListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apods = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = null,
    Object? searchQuery = null,
    Object? oldestLoadedDate = freezed,
  }) {
    return _then(_$ApodListStateImpl(
      apods: null == apods
          ? _value._apods
          : apods // ignore: cast_nullable_to_non_nullable
              as List<Apod>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedEnd: null == hasReachedEnd
          ? _value.hasReachedEnd
          : hasReachedEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      oldestLoadedDate: freezed == oldestLoadedDate
          ? _value.oldestLoadedDate
          : oldestLoadedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ApodListStateImpl implements _ApodListState {
  const _$ApodListStateImpl(
      {final List<Apod> apods = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasReachedEnd = false,
      this.error = '',
      this.searchQuery = '',
      this.oldestLoadedDate})
      : _apods = apods;

  final List<Apod> _apods;
  @override
  @JsonKey()
  List<Apod> get apods {
    if (_apods is EqualUnmodifiableListView) return _apods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apods);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasReachedEnd;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  final DateTime? oldestLoadedDate;

  @override
  String toString() {
    return 'ApodListState(apods: $apods, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, error: $error, searchQuery: $searchQuery, oldestLoadedDate: $oldestLoadedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApodListStateImpl &&
            const DeepCollectionEquality().equals(other._apods, _apods) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.oldestLoadedDate, oldestLoadedDate) ||
                other.oldestLoadedDate == oldestLoadedDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_apods),
      isLoading,
      isLoadingMore,
      hasReachedEnd,
      error,
      searchQuery,
      oldestLoadedDate);

  /// Create a copy of ApodListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApodListStateImplCopyWith<_$ApodListStateImpl> get copyWith =>
      __$$ApodListStateImplCopyWithImpl<_$ApodListStateImpl>(this, _$identity);
}

abstract class _ApodListState implements ApodListState {
  const factory _ApodListState(
      {final List<Apod> apods,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasReachedEnd,
      final String error,
      final String searchQuery,
      final DateTime? oldestLoadedDate}) = _$ApodListStateImpl;

  @override
  List<Apod> get apods;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasReachedEnd;
  @override
  String get error;
  @override
  String get searchQuery;
  @override
  DateTime? get oldestLoadedDate;

  /// Create a copy of ApodListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApodListStateImplCopyWith<_$ApodListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
