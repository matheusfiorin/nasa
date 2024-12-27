// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'neo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NeoListState {
  List<Neo> get neos => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  /// Create a copy of NeoListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeoListStateCopyWith<NeoListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeoListStateCopyWith<$Res> {
  factory $NeoListStateCopyWith(
          NeoListState value, $Res Function(NeoListState) then) =
      _$NeoListStateCopyWithImpl<$Res, NeoListState>;
  @useResult
  $Res call({List<Neo> neos, bool isLoading, String error});
}

/// @nodoc
class _$NeoListStateCopyWithImpl<$Res, $Val extends NeoListState>
    implements $NeoListStateCopyWith<$Res> {
  _$NeoListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NeoListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? neos = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      neos: null == neos
          ? _value.neos
          : neos // ignore: cast_nullable_to_non_nullable
              as List<Neo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeoListStateImplCopyWith<$Res>
    implements $NeoListStateCopyWith<$Res> {
  factory _$$NeoListStateImplCopyWith(
          _$NeoListStateImpl value, $Res Function(_$NeoListStateImpl) then) =
      __$$NeoListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Neo> neos, bool isLoading, String error});
}

/// @nodoc
class __$$NeoListStateImplCopyWithImpl<$Res>
    extends _$NeoListStateCopyWithImpl<$Res, _$NeoListStateImpl>
    implements _$$NeoListStateImplCopyWith<$Res> {
  __$$NeoListStateImplCopyWithImpl(
      _$NeoListStateImpl _value, $Res Function(_$NeoListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NeoListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? neos = null,
    Object? isLoading = null,
    Object? error = null,
  }) {
    return _then(_$NeoListStateImpl(
      neos: null == neos
          ? _value._neos
          : neos // ignore: cast_nullable_to_non_nullable
              as List<Neo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NeoListStateImpl implements _NeoListState {
  const _$NeoListStateImpl(
      {required final List<Neo> neos,
      required this.isLoading,
      required this.error})
      : _neos = neos;

  final List<Neo> _neos;
  @override
  List<Neo> get neos {
    if (_neos is EqualUnmodifiableListView) return _neos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_neos);
  }

  @override
  final bool isLoading;
  @override
  final String error;

  @override
  String toString() {
    return 'NeoListState(neos: $neos, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeoListStateImpl &&
            const DeepCollectionEquality().equals(other._neos, _neos) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_neos), isLoading, error);

  /// Create a copy of NeoListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeoListStateImplCopyWith<_$NeoListStateImpl> get copyWith =>
      __$$NeoListStateImplCopyWithImpl<_$NeoListStateImpl>(this, _$identity);
}

abstract class _NeoListState implements NeoListState {
  const factory _NeoListState(
      {required final List<Neo> neos,
      required final bool isLoading,
      required final String error}) = _$NeoListStateImpl;

  @override
  List<Neo> get neos;
  @override
  bool get isLoading;
  @override
  String get error;

  /// Create a copy of NeoListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeoListStateImplCopyWith<_$NeoListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
