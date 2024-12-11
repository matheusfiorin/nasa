import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/domain/entity/apod.dart';

void main() {
  const tApod = Apod(
    date: '2024-01-01',
    title: 'Test Title',
    explanation: 'Test Explanation',
    url: 'https://example.com/image.jpg',
    mediaType: 'image',
    copyright: 'Test Copyright',
  );

  group('Apod Entity', () {
    test('should create a valid Apod instance', () {
      expect(tApod, isA<Apod>());
      expect(tApod.date, '2024-01-01');
    });

    test('should create two equal Apod instances when properties are the same', () {
      const tApod2 = Apod(
        date: '2024-01-01',
        title: 'Test Title',
        explanation: 'Test Explanation',
        url: 'https://example.com/image.jpg',
        mediaType: 'image',
        copyright: 'Test Copyright',
      );

      expect(tApod, equals(tApod2));
    });

    test('should create different Apod instances when properties are different', () {
      final tApod2 = tApod.copyWith(title: 'Different Title');
      expect(tApod, isNot(equals(tApod2)));
    });

    test('should create a valid JSON from a valid instance', () {
      final jsonApod = tApod.toJson();
      expect(jsonApod, isA<Map<String, dynamic>>());
      expect(jsonApod['date'], '2024-01-01');
    });

    test('should create a valid instance from a valid JSON', () {
      final jsonApod = tApod.toJson();
      final apod = Apod.fromJson(jsonApod);
      expect(apod, isA<Apod>());
      expect(apod.date, '2024-01-01');
    });
  });
}