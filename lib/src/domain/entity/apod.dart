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
    required String mediaType,
    String? copyright,
    String? hdUrl,
  }) = _Apod;

  factory Apod.fromJson(Map<String, dynamic> json) => _$ApodFromJson(json);
}
