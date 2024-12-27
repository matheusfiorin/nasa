// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'neo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Neo _$NeoFromJson(Map<String, dynamic> json) {
  return _Neo.fromJson(json);
}

/// @nodoc
mixin _$Neo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'absolute_magnitude_h')
  double get absoluteMagnitudeH => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_potentially_hazardous_asteroid')
  bool get isPotentiallyHazardous => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_approach_data')
  List<CloseApproachData> get closeApproachData =>
      throw _privateConstructorUsedError;

  /// Serializes this Neo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Neo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeoCopyWith<Neo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeoCopyWith<$Res> {
  factory $NeoCopyWith(Neo value, $Res Function(Neo) then) =
      _$NeoCopyWithImpl<$Res, Neo>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'absolute_magnitude_h') double absoluteMagnitudeH,
      @JsonKey(name: 'is_potentially_hazardous_asteroid')
      bool isPotentiallyHazardous,
      @JsonKey(name: 'close_approach_data')
      List<CloseApproachData> closeApproachData});
}

/// @nodoc
class _$NeoCopyWithImpl<$Res, $Val extends Neo> implements $NeoCopyWith<$Res> {
  _$NeoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Neo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? absoluteMagnitudeH = null,
    Object? isPotentiallyHazardous = null,
    Object? closeApproachData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      absoluteMagnitudeH: null == absoluteMagnitudeH
          ? _value.absoluteMagnitudeH
          : absoluteMagnitudeH // ignore: cast_nullable_to_non_nullable
              as double,
      isPotentiallyHazardous: null == isPotentiallyHazardous
          ? _value.isPotentiallyHazardous
          : isPotentiallyHazardous // ignore: cast_nullable_to_non_nullable
              as bool,
      closeApproachData: null == closeApproachData
          ? _value.closeApproachData
          : closeApproachData // ignore: cast_nullable_to_non_nullable
              as List<CloseApproachData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeoImplCopyWith<$Res> implements $NeoCopyWith<$Res> {
  factory _$$NeoImplCopyWith(_$NeoImpl value, $Res Function(_$NeoImpl) then) =
      __$$NeoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'absolute_magnitude_h') double absoluteMagnitudeH,
      @JsonKey(name: 'is_potentially_hazardous_asteroid')
      bool isPotentiallyHazardous,
      @JsonKey(name: 'close_approach_data')
      List<CloseApproachData> closeApproachData});
}

/// @nodoc
class __$$NeoImplCopyWithImpl<$Res> extends _$NeoCopyWithImpl<$Res, _$NeoImpl>
    implements _$$NeoImplCopyWith<$Res> {
  __$$NeoImplCopyWithImpl(_$NeoImpl _value, $Res Function(_$NeoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Neo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? absoluteMagnitudeH = null,
    Object? isPotentiallyHazardous = null,
    Object? closeApproachData = null,
  }) {
    return _then(_$NeoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      absoluteMagnitudeH: null == absoluteMagnitudeH
          ? _value.absoluteMagnitudeH
          : absoluteMagnitudeH // ignore: cast_nullable_to_non_nullable
              as double,
      isPotentiallyHazardous: null == isPotentiallyHazardous
          ? _value.isPotentiallyHazardous
          : isPotentiallyHazardous // ignore: cast_nullable_to_non_nullable
              as bool,
      closeApproachData: null == closeApproachData
          ? _value._closeApproachData
          : closeApproachData // ignore: cast_nullable_to_non_nullable
              as List<CloseApproachData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NeoImpl implements _Neo {
  const _$NeoImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'absolute_magnitude_h') required this.absoluteMagnitudeH,
      @JsonKey(name: 'is_potentially_hazardous_asteroid')
      required this.isPotentiallyHazardous,
      @JsonKey(name: 'close_approach_data')
      required final List<CloseApproachData> closeApproachData})
      : _closeApproachData = closeApproachData;

  factory _$NeoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'absolute_magnitude_h')
  final double absoluteMagnitudeH;
  @override
  @JsonKey(name: 'is_potentially_hazardous_asteroid')
  final bool isPotentiallyHazardous;
  final List<CloseApproachData> _closeApproachData;
  @override
  @JsonKey(name: 'close_approach_data')
  List<CloseApproachData> get closeApproachData {
    if (_closeApproachData is EqualUnmodifiableListView)
      return _closeApproachData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_closeApproachData);
  }

  @override
  String toString() {
    return 'Neo(id: $id, name: $name, absoluteMagnitudeH: $absoluteMagnitudeH, isPotentiallyHazardous: $isPotentiallyHazardous, closeApproachData: $closeApproachData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.absoluteMagnitudeH, absoluteMagnitudeH) ||
                other.absoluteMagnitudeH == absoluteMagnitudeH) &&
            (identical(other.isPotentiallyHazardous, isPotentiallyHazardous) ||
                other.isPotentiallyHazardous == isPotentiallyHazardous) &&
            const DeepCollectionEquality()
                .equals(other._closeApproachData, _closeApproachData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      absoluteMagnitudeH,
      isPotentiallyHazardous,
      const DeepCollectionEquality().hash(_closeApproachData));

  /// Create a copy of Neo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeoImplCopyWith<_$NeoImpl> get copyWith =>
      __$$NeoImplCopyWithImpl<_$NeoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeoImplToJson(
      this,
    );
  }
}

abstract class _Neo implements Neo {
  const factory _Neo(
      {required final String id,
      required final String name,
      @JsonKey(name: 'absolute_magnitude_h')
      required final double absoluteMagnitudeH,
      @JsonKey(name: 'is_potentially_hazardous_asteroid')
      required final bool isPotentiallyHazardous,
      @JsonKey(name: 'close_approach_data')
      required final List<CloseApproachData> closeApproachData}) = _$NeoImpl;

  factory _Neo.fromJson(Map<String, dynamic> json) = _$NeoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'absolute_magnitude_h')
  double get absoluteMagnitudeH;
  @override
  @JsonKey(name: 'is_potentially_hazardous_asteroid')
  bool get isPotentiallyHazardous;
  @override
  @JsonKey(name: 'close_approach_data')
  List<CloseApproachData> get closeApproachData;

  /// Create a copy of Neo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeoImplCopyWith<_$NeoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CloseApproachData _$CloseApproachDataFromJson(Map<String, dynamic> json) {
  return _CloseApproachData.fromJson(json);
}

/// @nodoc
mixin _$CloseApproachData {
  @JsonKey(name: 'close_approach_date')
  String get closeApproachDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'miss_distance')
  MissDistance get missDistance => throw _privateConstructorUsedError;

  /// Serializes this CloseApproachData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloseApproachDataCopyWith<CloseApproachData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloseApproachDataCopyWith<$Res> {
  factory $CloseApproachDataCopyWith(
          CloseApproachData value, $Res Function(CloseApproachData) then) =
      _$CloseApproachDataCopyWithImpl<$Res, CloseApproachData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'close_approach_date') String closeApproachDate,
      @JsonKey(name: 'miss_distance') MissDistance missDistance});

  $MissDistanceCopyWith<$Res> get missDistance;
}

/// @nodoc
class _$CloseApproachDataCopyWithImpl<$Res, $Val extends CloseApproachData>
    implements $CloseApproachDataCopyWith<$Res> {
  _$CloseApproachDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? closeApproachDate = null,
    Object? missDistance = null,
  }) {
    return _then(_value.copyWith(
      closeApproachDate: null == closeApproachDate
          ? _value.closeApproachDate
          : closeApproachDate // ignore: cast_nullable_to_non_nullable
              as String,
      missDistance: null == missDistance
          ? _value.missDistance
          : missDistance // ignore: cast_nullable_to_non_nullable
              as MissDistance,
    ) as $Val);
  }

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MissDistanceCopyWith<$Res> get missDistance {
    return $MissDistanceCopyWith<$Res>(_value.missDistance, (value) {
      return _then(_value.copyWith(missDistance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CloseApproachDataImplCopyWith<$Res>
    implements $CloseApproachDataCopyWith<$Res> {
  factory _$$CloseApproachDataImplCopyWith(_$CloseApproachDataImpl value,
          $Res Function(_$CloseApproachDataImpl) then) =
      __$$CloseApproachDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'close_approach_date') String closeApproachDate,
      @JsonKey(name: 'miss_distance') MissDistance missDistance});

  @override
  $MissDistanceCopyWith<$Res> get missDistance;
}

/// @nodoc
class __$$CloseApproachDataImplCopyWithImpl<$Res>
    extends _$CloseApproachDataCopyWithImpl<$Res, _$CloseApproachDataImpl>
    implements _$$CloseApproachDataImplCopyWith<$Res> {
  __$$CloseApproachDataImplCopyWithImpl(_$CloseApproachDataImpl _value,
      $Res Function(_$CloseApproachDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? closeApproachDate = null,
    Object? missDistance = null,
  }) {
    return _then(_$CloseApproachDataImpl(
      closeApproachDate: null == closeApproachDate
          ? _value.closeApproachDate
          : closeApproachDate // ignore: cast_nullable_to_non_nullable
              as String,
      missDistance: null == missDistance
          ? _value.missDistance
          : missDistance // ignore: cast_nullable_to_non_nullable
              as MissDistance,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloseApproachDataImpl implements _CloseApproachData {
  const _$CloseApproachDataImpl(
      {@JsonKey(name: 'close_approach_date') required this.closeApproachDate,
      @JsonKey(name: 'miss_distance') required this.missDistance});

  factory _$CloseApproachDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloseApproachDataImplFromJson(json);

  @override
  @JsonKey(name: 'close_approach_date')
  final String closeApproachDate;
  @override
  @JsonKey(name: 'miss_distance')
  final MissDistance missDistance;

  @override
  String toString() {
    return 'CloseApproachData(closeApproachDate: $closeApproachDate, missDistance: $missDistance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloseApproachDataImpl &&
            (identical(other.closeApproachDate, closeApproachDate) ||
                other.closeApproachDate == closeApproachDate) &&
            (identical(other.missDistance, missDistance) ||
                other.missDistance == missDistance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, closeApproachDate, missDistance);

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloseApproachDataImplCopyWith<_$CloseApproachDataImpl> get copyWith =>
      __$$CloseApproachDataImplCopyWithImpl<_$CloseApproachDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloseApproachDataImplToJson(
      this,
    );
  }
}

abstract class _CloseApproachData implements CloseApproachData {
  const factory _CloseApproachData(
      {@JsonKey(name: 'close_approach_date')
      required final String closeApproachDate,
      @JsonKey(name: 'miss_distance')
      required final MissDistance missDistance}) = _$CloseApproachDataImpl;

  factory _CloseApproachData.fromJson(Map<String, dynamic> json) =
      _$CloseApproachDataImpl.fromJson;

  @override
  @JsonKey(name: 'close_approach_date')
  String get closeApproachDate;
  @override
  @JsonKey(name: 'miss_distance')
  MissDistance get missDistance;

  /// Create a copy of CloseApproachData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloseApproachDataImplCopyWith<_$CloseApproachDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissDistance _$MissDistanceFromJson(Map<String, dynamic> json) {
  return _MissDistance.fromJson(json);
}

/// @nodoc
mixin _$MissDistance {
  String get kilometers => throw _privateConstructorUsedError;

  /// Serializes this MissDistance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissDistance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissDistanceCopyWith<MissDistance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissDistanceCopyWith<$Res> {
  factory $MissDistanceCopyWith(
          MissDistance value, $Res Function(MissDistance) then) =
      _$MissDistanceCopyWithImpl<$Res, MissDistance>;
  @useResult
  $Res call({String kilometers});
}

/// @nodoc
class _$MissDistanceCopyWithImpl<$Res, $Val extends MissDistance>
    implements $MissDistanceCopyWith<$Res> {
  _$MissDistanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissDistance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kilometers = null,
  }) {
    return _then(_value.copyWith(
      kilometers: null == kilometers
          ? _value.kilometers
          : kilometers // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissDistanceImplCopyWith<$Res>
    implements $MissDistanceCopyWith<$Res> {
  factory _$$MissDistanceImplCopyWith(
          _$MissDistanceImpl value, $Res Function(_$MissDistanceImpl) then) =
      __$$MissDistanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String kilometers});
}

/// @nodoc
class __$$MissDistanceImplCopyWithImpl<$Res>
    extends _$MissDistanceCopyWithImpl<$Res, _$MissDistanceImpl>
    implements _$$MissDistanceImplCopyWith<$Res> {
  __$$MissDistanceImplCopyWithImpl(
      _$MissDistanceImpl _value, $Res Function(_$MissDistanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissDistance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kilometers = null,
  }) {
    return _then(_$MissDistanceImpl(
      kilometers: null == kilometers
          ? _value.kilometers
          : kilometers // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissDistanceImpl implements _MissDistance {
  const _$MissDistanceImpl({required this.kilometers});

  factory _$MissDistanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissDistanceImplFromJson(json);

  @override
  final String kilometers;

  @override
  String toString() {
    return 'MissDistance(kilometers: $kilometers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissDistanceImpl &&
            (identical(other.kilometers, kilometers) ||
                other.kilometers == kilometers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, kilometers);

  /// Create a copy of MissDistance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissDistanceImplCopyWith<_$MissDistanceImpl> get copyWith =>
      __$$MissDistanceImplCopyWithImpl<_$MissDistanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissDistanceImplToJson(
      this,
    );
  }
}

abstract class _MissDistance implements MissDistance {
  const factory _MissDistance({required final String kilometers}) =
      _$MissDistanceImpl;

  factory _MissDistance.fromJson(Map<String, dynamic> json) =
      _$MissDistanceImpl.fromJson;

  @override
  String get kilometers;

  /// Create a copy of MissDistance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissDistanceImplCopyWith<_$MissDistanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
