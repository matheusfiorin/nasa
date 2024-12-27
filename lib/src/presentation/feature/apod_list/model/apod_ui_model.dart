import 'package:nasa/src/core/utils/formatter.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodUiModel {
  final String date;
  final String title;
  final String imageUrl;
  final String mediaType;
  final bool isVideo;
  final String? thumbnailUrl;
  final String explanation;

  const ApodUiModel({
    required this.date,
    required this.title,
    required this.imageUrl,
    required this.mediaType,
    required this.explanation,
    this.thumbnailUrl,
  }) : isVideo = mediaType == 'video';

  factory ApodUiModel.fromEntity(Apod apod) {
    return ApodUiModel(
      date: apod.date,
      title: apod.title,
      imageUrl: apod.url,
      mediaType: apod.mediaType,
      explanation: apod.explanation,
      thumbnailUrl: apod.mediaType == 'video'
          ? Formatter.extractVideoThumbnail(apod.url)
          : null,
    );
  }

  Apod toEntity() {
    return Apod(
      date: date,
      title: title,
      explanation: explanation,
      url: imageUrl,
      mediaType: mediaType,
    );
  }
}
