import 'package:hive/hive.dart';
import 'package:nasa/src/domain/entity/apod.dart';

part 'apod_hive_model.g.dart';

@HiveType(typeId: 0)
class ApodHiveModel extends HiveObject {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String explanation;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String mediaType;

  @HiveField(5)
  final String? copyright;

  ApodHiveModel({
    required this.date,
    required this.title,
    required this.explanation,
    required this.url,
    required this.mediaType,
    this.copyright,
  });

  factory ApodHiveModel.fromApod(Apod apod) {
    return ApodHiveModel(
      date: apod.date,
      title: apod.title,
      explanation: apod.explanation,
      url: apod.url,
      mediaType: apod.mediaType,
      copyright: apod.copyright,
    );
  }

  Apod toEntity() {
    return Apod(
      date: date,
      title: title,
      explanation: explanation,
      url: url,
      mediaType: mediaType,
      copyright: copyright,
    );
  }
}
