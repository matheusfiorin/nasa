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
  late ApodRemoteProviderImpl Provider;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    Provider = ApodRemoteProviderImpl(dio: dio);
  });

  group('getApodList', () {
    const tDate = '2024-01-01';
    const tEndDate = '2024-01-07';
    final tPath = ApiConfig.getApodListUri(tDate, tEndDate);

    test('should return List<ApodModel> when the response code is 200',
        () async {
      final jsonList = [json.decode(fixture('apod.json'))];
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(200, jsonList),
      );

      final result = await Provider.getApodList(tDate, tEndDate);

      expect(result, isA<List<ApodModel>>());
      expect(result.length, 1);
    });

    test(
        'should return List<ApodModel> when the response code is 200 and receives a map',
        () async {
      final jsonMap = json.decode(fixture('apod.json'));
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(200, jsonMap),
      );

      final result = await Provider.getApodList(tDate, tEndDate);

      expect(result, isA<List<ApodModel>>());
      expect(result.length, 1);
    });

    test('should throw ServerException when the response code is 404',
        () async {
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(404, 'Not Found'),
      );

      final call = Provider.getApodList;

      expect(() => call(tDate, tEndDate), throwsA(isA<ServerException>()));
    });

    test('should throw ServerException when the response code is not 202',
        () async {
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(202, 'Accepted'),
      );

      final call = Provider.getApodList;

      expect(() => call(tDate, tEndDate), throwsA(isA<ServerException>()));
    });
  });

  group('searchApod', () {
    const tDate = '2024-01-01';
    final tPath = ApiConfig.searchApodUri(tDate);

    test('should return ApodModel when the response code is 200', () async {
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(200, json.decode(fixture('apod.json'))),
      );

      final result = await Provider.getApodByDate(tDate);

      expect(result, isA<ApodModel>());
    });

    test('should throw ServerException when the response code is 404',
        () async {
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(404, 'Not Found'),
      );

      final call = Provider.getApodByDate;

      expect(() => call(tDate), throwsA(isA<ServerException>()));
    });

    test('should throw ServerException when the response code is 202',
        () async {
      dioAdapter.onGet(
        tPath,
        (server) => server.reply(202, 'Accepted'),
      );

      final call = Provider.getApodByDate;

      expect(() => call(tDate), throwsA(isA<ServerException>()));
    });
  });
}
