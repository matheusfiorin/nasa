import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/data/filter/apod_filter.dart';
import 'package:nasa/src/domain/entity/apod.dart';

void main() {
  group('ApodFilter', () {
    late List<Apod> testApods;

    setUp(() {
      testApods = [
        const Apod(
          date: '2024-03-15',
          title: 'First Title',
          explanation: 'Test Explanation',
          url: 'https://example.com/1.jpg',
          mediaType: 'image',
        ),
        const Apod(
          date: '2024-03-16',
          title: 'Second Title',
          explanation: 'Test Explanation',
          url: 'https://example.com/2.jpg',
          mediaType: 'image',
        ),
        const Apod(
          date: '2024-03-17',
          title: 'Third Title',
          explanation: 'Test Explanation',
          url: 'https://example.com/3.jpg',
          mediaType: 'image',
        ),
      ];
    });

    group('byDateRange', () {
      test('should return apods within date range inclusive', () {
        final startDate = DateTime(2024, 3, 15);
        final endDate = DateTime(2024, 3, 16);

        final result = ApodFilter.byDateRange(testApods, startDate, endDate);

        expect(result.length, equals(2));
        expect(result[0].date, equals('2024-03-15'));
        expect(result[1].date, equals('2024-03-16'));
      });

      test('should return empty list when no apods in range', () {
        final startDate = DateTime(2024, 3, 20);
        final endDate = DateTime(2024, 3, 21);

        final result = ApodFilter.byDateRange(testApods, startDate, endDate);

        expect(result, isEmpty);
      });
    });

    group('bySearchQuery', () {
      test('should return apods matching title query case-insensitive', () {
        final result = ApodFilter.bySearchQuery(testApods, 'first');

        expect(result.length, equals(1));
        expect(result[0].title, equals('First Title'));
      });

      test('should return apods matching date query', () {
        final result = ApodFilter.bySearchQuery(testApods, '2024-03-16');

        expect(result.length, equals(1));
        expect(result[0].date, equals('2024-03-16'));
      });

      test('should return empty list when no matches found', () {
        final result = ApodFilter.bySearchQuery(testApods, 'nonexistent');

        expect(result, isEmpty);
      });
    });
  });
}
