import 'package:freezed_annotation/freezed_annotation.dart';

part 'neo.freezed.dart';
part 'neo.g.dart';

@freezed
class Neo with _$Neo {
  const factory Neo({
    required String id,
    required String name,
    @JsonKey(name: 'absolute_magnitude_h') required double absoluteMagnitudeH,
    @JsonKey(name: 'is_potentially_hazardous_asteroid')
    required bool isPotentiallyHazardous,
    @JsonKey(name: 'close_approach_data')
    required List<CloseApproachData> closeApproachData,
  }) = _Neo;

  factory Neo.fromJson(Map<String, dynamic> json) => _$NeoFromJson(json);
}

@freezed
class CloseApproachData with _$CloseApproachData {
  const factory CloseApproachData({
    @JsonKey(name: 'close_approach_date') required String closeApproachDate,
    @JsonKey(name: 'miss_distance') required MissDistance missDistance,
  }) = _CloseApproachData;

  factory CloseApproachData.fromJson(Map<String, dynamic> json) =>
      _$CloseApproachDataFromJson(json);
}

@freezed
class MissDistance with _$MissDistance {
  const factory MissDistance({
    required String kilometers,
  }) = _MissDistance;

  factory MissDistance.fromJson(Map<String, dynamic> json) =>
      _$MissDistanceFromJson(json);
}
