// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApodImpl _$$ApodImplFromJson(Map<String, dynamic> json) => _$ApodImpl(
      date: json['date'] as String,
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      url: json['url'] as String,
      mediaType: json['media_type'] as String,
      copyright: json['copyright'] as String?,
    );

Map<String, dynamic> _$$ApodImplToJson(_$ApodImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'explanation': instance.explanation,
      'url': instance.url,
      'media_type': instance.mediaType,
      'copyright': instance.copyright,
    };
