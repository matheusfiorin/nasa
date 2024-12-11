import 'package:freezed_annotation/freezed_annotation.dart';

part 'apod.freezed.dart';

part 'apod.g.dart';

@freezed
class Apod with _$Apod {
  const factory Apod({
    required String date,
    required String title,
    required String explanation,
    required String url,
    @JsonKey(name: 'media_type') required String mediaType,
    String? copyright,
  }) = _Apod;

  factory Apod.fromJson(Map<String, dynamic> json) => _$ApodFromJson(json);
}
