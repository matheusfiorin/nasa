// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NeoImpl _$$NeoImplFromJson(Map<String, dynamic> json) => _$NeoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      absoluteMagnitudeH: (json['absolute_magnitude_h'] as num).toDouble(),
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'] as bool,
      closeApproachData: (json['close_approach_data'] as List<dynamic>)
          .map((e) => CloseApproachData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NeoImplToJson(_$NeoImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'absolute_magnitude_h': instance.absoluteMagnitudeH,
      'is_potentially_hazardous_asteroid': instance.isPotentiallyHazardous,
      'close_approach_data': instance.closeApproachData,
    };

_$CloseApproachDataImpl _$$CloseApproachDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CloseApproachDataImpl(
      closeApproachDate: json['close_approach_date'] as String,
      missDistance:
          MissDistance.fromJson(json['miss_distance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CloseApproachDataImplToJson(
        _$CloseApproachDataImpl instance) =>
    <String, dynamic>{
      'close_approach_date': instance.closeApproachDate,
      'miss_distance': instance.missDistance,
    };

_$MissDistanceImpl _$$MissDistanceImplFromJson(Map<String, dynamic> json) =>
    _$MissDistanceImpl(
      kilometers: json['kilometers'] as String,
    );

Map<String, dynamic> _$$MissDistanceImplToJson(_$MissDistanceImpl instance) =>
    <String, dynamic>{
      'kilometers': instance.kilometers,
    };
