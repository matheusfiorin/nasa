import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_model.dart';
import 'package:nasa/src/data/provider/remote/apod_remote_provider.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ApodRemoteDataSourceImpl dataSource;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    dataSource = ApodRemoteDataSourceImpl(dio: dio);
  });

  group('getApodList', () {
    const tDate = '2024-01-01';
    const tEndDate = '2024-01-07';
    final tPath = ApiConfig.getApodList(tDate, tEndDate);

    test('should return List<ApodModel> when the response code is 200', () async {
      final jsonList = [json.decode(fixture('apod.json'))];
      dioAdapter.onGet(
        tPath,
            (server) => server.reply(200, jsonList),
      );

      final result = await dataSource.getApodList(tDate, tEndDate);

      expect(result, isA<List<ApodModel>>());
      expect(result.length, 1);
    });

    test('should throw ServerException when the response code is not 200',
            () async {
          dioAdapter.onGet(
            tPath,
                (server) => server.reply(404, 'Not Found'),
          );

          final call = dataSource.getApodList;

          expect(() => call(tDate, tEndDate), throwsA(isA<ServerException>()));
        });
  });
}