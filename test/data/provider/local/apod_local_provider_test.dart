import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/provider/local/apod_local_provider.dart';

class MockHiveBox extends Mock implements Box<ApodHiveModel> {}

void main() {
  late ApodLocalDataSourceImpl dataSource;
  late MockHiveBox mockBox;

  setUp(() {
    mockBox = MockHiveBox();
    dataSource = ApodLocalDataSourceImpl(apodBox: mockBox);
  });

  group('getApodList', () {
    final tApodModel = ApodHiveModel(
      date: '2024-01-01',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should return List<ApodHiveModel> from the local storage', () async {
      when(() => mockBox.values).thenReturn([tApodModel]);

      final result = await dataSource.getApodList();

      verify(() => mockBox.values).called(1);
      expect(result, [tApodModel]);
    });

    test('should throw CacheException when there is no cached data', () async {
      when(() => mockBox.values).thenThrow(Exception());

      final call = dataSource.getApodList;

      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}