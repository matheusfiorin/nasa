import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/config/api_config.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_model.dart';
import 'package:nasa/src/data/provider/remote/apod_remote_provider.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
import 'apod_remote_provider_test.mocks.dart';

void main() {
  dotenv.testLoad(fileInput: ''' NASA_API_KEY=DEMO_KEY ''');

  late ApodRemoteProviderImpl remoteProvider;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    remoteProvider = ApodRemoteProviderImpl(dio: mockDio);
  });

  group('getApodList', () {
    const startDate = '2024-03-15';
    const endDate = '2024-03-16';
    final uri = ApiConfig.getApodListUri(startDate, endDate);

    final tApodJson = {
      'date': '2024-03-15',
      'title': 'Test Title',
      'explanation': 'Test Explanation',
      'url': 'https://example.com/image.jpg',
      'media_type': 'image',
      'copyright': 'Test Copyright\nTest',
    };

    test('should return list of ApodModels when response is a list', () async {
      final responseData = [tApodJson, tApodJson];
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final result = await remoteProvider.getApodList(startDate, endDate);

      expect(result.length, 2);
      expect(result[0], isA<ApodModel>());
      expect(result[0].copyright, 'Test Copyright Test');
      verify(mockDio.get(uri));
    });

    test('should return single ApodModel when response is a map', () async {
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: tApodJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final result = await remoteProvider.getApodList(startDate, endDate);

      expect(result.length, 1);
      expect(result[0], isA<ApodModel>());
      verify(mockDio.get(uri));
    });

    test('should skip invalid items in list response', () async {
      final responseData = [
        tApodJson,
        {'invalid': 'data'},
        {'date': '2024-03-15', 'title': 'Test'},
        tApodJson,
      ];
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final result = await remoteProvider.getApodList(startDate, endDate);

      expect(result.length, 2);
      verify(mockDio.get(uri));
    });

    test('should throw ServerException when no valid APODs in response',
        () async {
      final responseData = [
        {'invalid': 'data'},
        {'date': '2024-03-15'},
      ];
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final call = remoteProvider.getApodList;

      expect(
        () => call(startDate, endDate),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'No valid APODs in response',
          ),
        ),
      );
    });

    test('should throw ServerException for unexpected response format',
        () async {
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: 'invalid data',
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final call = remoteProvider.getApodList;

      expect(
        () => call(startDate, endDate),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'Unexpected response format',
          ),
        ),
      );
    });

    test('should throw ServerException for non-200 status code', () async {
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 404,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final call = remoteProvider.getApodList;

      expect(
        () => call(startDate, endDate),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'Server returned 404',
          ),
        ),
      );
    });

    test('should throw ServerException when Dio throws error', () async {
      when(mockDio.get(uri)).thenThrow(DioException(
        requestOptions: RequestOptions(path: uri),
        error: 'Network error',
      ));

      final call = remoteProvider.getApodList;

      expect(
        () => call(startDate, endDate),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getApodByDate', () {
    const date = '2024-03-15';
    final uri = ApiConfig.searchApodUri(date);

    final tApodJson = {
      'date': date,
      'title': 'Test Title',
      'explanation': 'Test Explanation',
      'url': 'https://example.com/image.jpg',
      'media_type': 'image',
    };

    test('should return ApodModel for successful response', () async {
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: tApodJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final result = await remoteProvider.getApodByDate(date);

      expect(result, isA<ApodModel>());
      expect(result.date, date);
      verify(mockDio.get(uri));
    });

    test('should throw ServerException for non-200 status code', () async {
      when(mockDio.get(uri)).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 404,
          requestOptions: RequestOptions(path: uri),
        ),
      );

      final call = remoteProvider.getApodByDate;

      expect(
        () => call(date),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'Error in getApodByDate: Server returned 404',
          ),
        ),
      );
    });

    test('should throw ServerException when Dio throws error', () async {
      when(mockDio.get(uri)).thenThrow(DioException(
        requestOptions: RequestOptions(path: uri),
        error: 'Network error',
      ));

      final call = remoteProvider.getApodByDate;

      expect(
        () => call(date),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            contains('Error in getApodByDate'),
          ),
        ),
      );
    });
  });
}
