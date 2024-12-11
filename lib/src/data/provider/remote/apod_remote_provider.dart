import 'package:dio/dio.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/utils/formatter.dart';
import 'package:nasa/src/data/model/apod_model.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';

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
              if (json['copyright'] != null) {
                json['copyright'] = Formatter.copyright(json['copyright']);
              }

              if (!json.containsKey('date') ||
                  !json.containsKey('title') ||
                  !json.containsKey('media_type')) {
                continue;
              }

              if (!json.containsKey('url')) {
                continue;
              }

              try {
                results.add(ApodModel.fromJson(json));
              } catch (e) {
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
          final json = response.data as Map<String, dynamic>;

          return [ApodModel.fromJson(json)];
        }

        throw ServerException('Unexpected response format');
      }
      throw ServerException('Server returned ${response.statusCode}');
    } catch (e) {
      throw ServerException(e.toString());
    }
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
