import 'package:dio/dio.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/neo_model.dart';

class NeoRemoteProvider {
  final Dio dio;

  NeoRemoteProvider({required this.dio});

  Future<List<NeoModel>> getNeoList(String startDate, String endDate) async {
    try {
      final response = await dio.get(
        '${ApiConfig.baseNeoUrl}?start_date=$startDate&end_date=$endDate',
      );

      if (response.statusCode == 200) {
        final List<NeoModel> results = [];
        final data = response.data['near_earth_objects'][startDate] as List;
        for (final json in data) {
          results.add(NeoModel.fromJson(json));
        }
        return results;
      } else {
        throw ServerException('Failed to fetch NEO list');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
