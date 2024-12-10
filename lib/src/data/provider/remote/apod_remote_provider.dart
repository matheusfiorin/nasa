import 'package:dio/dio.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_model.dart';

abstract class ApodRemoteProvider {
  Future<List<ApodModel>> getApodList(String startDate, String endDate);

  Future<ApodModel> getApodByDate(String date);
}

class ApodRemoteProviderImpl implements ApodRemoteProvider {
  final Dio dio;

  ApodRemoteProviderImpl({required this.dio});

  @override
  Future<List<ApodModel>> getApodList(String startDate, String endDate) async {
    try {
      final response = await dio.get(
        ApiConfig.getApodListUri(startDate, endDate),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          final List<ApodModel> results = [];

          for (final json in response.data as List) {
            if (json is Map<String, dynamic>) {
              // Clean up copyright field
              if (json['copyright'] != null) {
                json['copyright'] = json['copyright']
                    .toString()
                    .trim()
                    .replaceAll('\n', ' ')
                    .replaceAll(RegExp(r'\s+'), ' ');
              }

              // Check required fields
              if (!json.containsKey('date') ||
                  !json.containsKey('title') ||
                  !json.containsKey('media_type')) {
                continue; // Skip this entry
              }

              // For videos, use thumbnail URL or a placeholder
              if (json['media_type'] == 'video') {
                // Use thumbnail_url if available, otherwise use a placeholder
                json['url'] = json['thumbnail_url'] ??
                    'https://img.youtube.com/vi/${_extractVideoId(json['url'])}/0.jpg';
              } else if (!json.containsKey('url')) {
                continue; // Skip entries without URLs for other media types
              }

              try {
                results.add(ApodModel.fromJson(json));
              } catch (e) {
                print('Error parsing APOD: $e');
                print('Problematic JSON: $json');
                // Continue to next item instead of throwing
                continue;
              }
            }
          }

          if (results.isEmpty) {
            throw ServerException('No valid APODs in response');
          }

          return results;
        }

        if (response.data is Map<String, dynamic>) {
          // Handle single item response with same logic
          final json = response.data as Map<String, dynamic>;

          if (json['media_type'] == 'video') {
            json['url'] = json['thumbnail_url'] ??
                'https://img.youtube.com/vi/${_extractVideoId(json['url'])}/0.jpg';
          }

          return [ApodModel.fromJson(json)];
        }

        throw ServerException('Unexpected response format');
      }
      throw ServerException('Server returned ${response.statusCode}');
    } catch (e) {
      print('Error in getApodList: $e');
      throw ServerException(e.toString());
    }
  }

  String? _extractVideoId(String? url) {
    if (url == null) return null;

    // Extract YouTube video ID from URL
    final regex = RegExp(
      r'(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  @override
  Future<ApodModel> getApodByDate(String date) async {
    try {
      final response = await dio.get(
        ApiConfig.searchApodUri(date),
      );

      if (response.statusCode == 200) {
        return ApodModel.fromJson(response.data);
      }
      throw ServerException('Server returned ${response.statusCode}');
    } catch (e) {
      throw ServerException('Error in getApodByDate: $e');
    }
  }
}
