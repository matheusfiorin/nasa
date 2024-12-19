import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/data/mapper/apod_mapper.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/domain/entity/apod.dart';

void main() {
  group('ApodMapper', () {
    const testDate = '2024-03-15';
    const testTitle = 'Test Title';
    const testExplanation = 'Test Explanation';
    const testUrl = 'https://example.com/image.jpg';
    const testMediaType = 'image';

    const testApod = Apod(
      date: testDate,
      title: testTitle,
      explanation: testExplanation,
      url: testUrl,
      mediaType: testMediaType,
    );

    final testHiveModel = ApodHiveModel(
      date: testDate,
      title: testTitle,
      explanation: testExplanation,
      url: testUrl,
      mediaType: testMediaType,
    );

    test('toHiveModel should correctly map Apod to ApodHiveModel', () {
      final result = ApodMapper.toHiveModel(testApod);

      expect(result.date, equals(testDate));
      expect(result.title, equals(testTitle));
      expect(result.explanation, equals(testExplanation));
      expect(result.url, equals(testUrl));
      expect(result.mediaType, equals(testMediaType));
    });

    test('toEntity should correctly map ApodHiveModel to Apod', () {
      final result = ApodMapper.toEntity(testHiveModel);

      expect(result.date, equals(testDate));
      expect(result.title, equals(testTitle));
      expect(result.explanation, equals(testExplanation));
      expect(result.url, equals(testUrl));
      expect(result.mediaType, equals(testMediaType));
    });

    test('toEntityList should correctly map list of ApodHiveModel to list of Apod', () {
      final result = ApodMapper.toEntityList([testHiveModel, testHiveModel]);

      expect(result.length, equals(2));
      expect(result[0], isA<Apod>());
      expect(result[1], isA<Apod>());
    });

    test('toHiveModelList should correctly map list of Apod to list of ApodHiveModel', () {
      final result = ApodMapper.toHiveModelList([testApod, testApod]);

      expect(result.length, equals(2));
      expect(result[0], isA<ApodHiveModel>());
      expect(result[1], isA<ApodHiveModel>());
    });
  });
}
