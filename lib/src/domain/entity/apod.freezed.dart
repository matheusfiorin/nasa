// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Apod _$ApodFromJson(Map<String, dynamic> json) {
  return _Apod.fromJson(json);
}

/// @nodoc
mixin _$Apod {
  String get date => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get mediaType => throw _privateConstructorUsedError;
  String? get copyright => throw _privateConstructorUsedError;
  String? get hdUrl => throw _privateConstructorUsedError;

  /// Serializes this Apod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Apod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApodCopyWith<Apod> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApodCopyWith<$Res> {
  factory $ApodCopyWith(Apod value, $Res Function(Apod) then) =
      _$ApodCopyWithImpl<$Res, Apod>;
  @useResult
  $Res call(
      {String date,
      String title,
      String explanation,
      String url,
      String mediaType,
      String? copyright,
      String? hdUrl});
}

/// @nodoc
class _$ApodCopyWithImpl<$Res, $Val extends Apod>
    implements $ApodCopyWith<$Res> {
  _$ApodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Apod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? explanation = null,
    Object? url = null,
    Object? mediaType = null,
    Object? copyright = freezed,
    Object? hdUrl = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      hdUrl: freezed == hdUrl
          ? _value.hdUrl
          : hdUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApodImplCopyWith<$Res> implements $ApodCopyWith<$Res> {
  factory _$$ApodImplCopyWith(
          _$ApodImpl value, $Res Function(_$ApodImpl) then) =
      __$$ApodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String title,
      String explanation,
      String url,
      String mediaType,
      String? copyright,
      String? hdUrl});
}

/// @nodoc
class __$$ApodImplCopyWithImpl<$Res>
    extends _$ApodCopyWithImpl<$Res, _$ApodImpl>
    implements _$$ApodImplCopyWith<$Res> {
  __$$ApodImplCopyWithImpl(_$ApodImpl _value, $Res Function(_$ApodImpl) _then)
      : super(_value, _then);

  /// Create a copy of Apod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? explanation = null,
    Object? url = null,
    Object? mediaType = null,
    Object? copyright = freezed,
    Object? hdUrl = freezed,
  }) {
    return _then(_$ApodImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      copyright: freezed == copyright
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      hdUrl: freezed == hdUrl
          ? _value.hdUrl
          : hdUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApodImpl implements _Apod {
  const _$ApodImpl(
      {required this.date,
      required this.title,
      required this.explanation,
      required this.url,
      required this.mediaType,
      this.copyright,
      this.hdUrl});

  factory _$ApodImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApodImplFromJson(json);

  @override
  final String date;
  @override
  final String title;
  @override
  final String explanation;
  @override
  final String url;
  @override
  final String mediaType;
  @override
  final String? copyright;
  @override
  final String? hdUrl;

  @override
  String toString() {
    return 'Apod(date: $date, title: $title, explanation: $explanation, url: $url, mediaType: $mediaType, copyright: $copyright, hdUrl: $hdUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApodImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.copyright, copyright) ||
                other.copyright == copyright) &&
            (identical(other.hdUrl, hdUrl) || other.hdUrl == hdUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, title, explanation, url, mediaType, copyright, hdUrl);

  /// Create a copy of Apod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApodImplCopyWith<_$ApodImpl> get copyWith =>
      __$$ApodImplCopyWithImpl<_$ApodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApodImplToJson(
      this,
    );
  }
}

abstract class _Apod implements Apod {
  const factory _Apod(
      {required final String date,
      required final String title,
      required final String explanation,
      required final String url,
      required final String mediaType,
      final String? copyright,
      final String? hdUrl}) = _$ApodImpl;

  factory _Apod.fromJson(Map<String, dynamic> json) = _$ApodImpl.fromJson;

  @override
  String get date;
  @override
  String get title;
  @override
  String get explanation;
  @override
  String get url;
  @override
  String get mediaType;
  @override
  String? get copyright;
  @override
  String? get hdUrl;

  /// Create a copy of Apod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApodImplCopyWith<_$ApodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
