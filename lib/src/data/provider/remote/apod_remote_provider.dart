import 'package:dio/dio.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/network/api_client.dart';
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
      final response = await sl<ApiClient>().get(
        ApiConfig.getApodList(startDate, endDate),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => ApodModel.fromJson(json))
              .toList();
        }
        return [ApodModel.fromJson(response.data)];
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ApodModel> getApodByDate(String date) async {
    try {
      final response = await dio.get(
        ApiConfig.searchApod(date),
      );

      if (response.statusCode == 200) {
        return ApodModel.fromJson(response.data);
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
