import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/domain/entity/apod.dart';

void main() {
  group('ApodHiveModel', () {
    const testDate = '2024-03-15';
    const testTitle = 'Test Title';
    const testExplanation = 'Test Explanation';
    const testUrl = 'https://example.com/image.jpg';
    const testMediaType = 'image';
    const testCopyright = 'Test Copyright';
    const testHdUrl = 'https://example.com/hd-image.jpg';

    group('fromApod', () {
      test('should create ApodHiveModel from Apod with all fields', () {
        const apod = Apod(
          date: testDate,
          title: testTitle,
          explanation: testExplanation,
          url: testUrl,
          mediaType: testMediaType,
          copyright: testCopyright,
        );

        final hiveModel = ApodHiveModel.fromApod(apod);

        expect(hiveModel.date, testDate);
        expect(hiveModel.title, testTitle);
        expect(hiveModel.explanation, testExplanation);
        expect(hiveModel.url, testUrl);
        expect(hiveModel.mediaType, testMediaType);
        expect(hiveModel.copyright, testCopyright);
      });

      test('should create ApodHiveModel from Apod with only required fields',
          () {
        const apod = Apod(
          date: testDate,
          title: testTitle,
          explanation: testExplanation,
          url: testUrl,
          mediaType: testMediaType,
        );

        final hiveModel = ApodHiveModel.fromApod(apod);

        expect(hiveModel.date, testDate);
        expect(hiveModel.title, testTitle);
        expect(hiveModel.explanation, testExplanation);
        expect(hiveModel.url, testUrl);
        expect(hiveModel.mediaType, testMediaType);
        expect(hiveModel.copyright, null);
      });
    });

    group('toEntity', () {
      test('should convert ApodHiveModel to Apod with all fields', () {
        final hiveModel = ApodHiveModel(
          date: testDate,
          title: testTitle,
          explanation: testExplanation,
          url: testUrl,
          mediaType: testMediaType,
          copyright: testCopyright,
        );

        final apod = hiveModel.toEntity();

        expect(apod.date, testDate);
        expect(apod.title, testTitle);
        expect(apod.explanation, testExplanation);
        expect(apod.url, testUrl);
        expect(apod.mediaType, testMediaType);
        expect(apod.copyright, testCopyright);
      });

      test('should convert ApodHiveModel to Apod with only required fields',
          () {
        final hiveModel = ApodHiveModel(
          date: testDate,
          title: testTitle,
          explanation: testExplanation,
          url: testUrl,
          mediaType: testMediaType,
        );

        final apod = hiveModel.toEntity();

        expect(apod.date, testDate);
        expect(apod.title, testTitle);
        expect(apod.explanation, testExplanation);
        expect(apod.url, testUrl);
        expect(apod.mediaType, testMediaType);
        expect(apod.copyright, null);
      });

      test('should preserve bidirectional transformation', () {
        const originalApod = Apod(
          date: testDate,
          title: testTitle,
          explanation: testExplanation,
          url: testUrl,
          mediaType: testMediaType,
          copyright: testCopyright,
        );

        final hiveModel = ApodHiveModel.fromApod(originalApod);
        final transformedApod = hiveModel.toEntity();

        expect(transformedApod.date, originalApod.date);
        expect(transformedApod.title, originalApod.title);
        expect(transformedApod.explanation, originalApod.explanation);
        expect(transformedApod.url, originalApod.url);
        expect(transformedApod.mediaType, originalApod.mediaType);
        expect(transformedApod.copyright, originalApod.copyright);
      });
    });
  });
}
