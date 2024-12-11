import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/core/utils/formatter.dart';
import 'package:nasa/src/domain/entity/apod.dart';

void main() {
  group('Formatter', () {
    group('copyright', () {
      test('should format copyright text correctly', () {
        const input = '''John Doe
        Photography''';
        const expected = 'John Doe Photography';

        final result = Formatter.copyright(input);

        expect(result, expected);
      });

      test('should handle single line text', () {
        const input = 'John   Doe';
        const expected = 'John Doe';

        final result = Formatter.copyright(input);

        expect(result, expected);
      });

      test('should handle empty string', () {
        const input = '';
        const expected = '';

        final result = Formatter.copyright(input);

        expect(result, expected);
      });
    });

    group('date', () {
      test('should format date correctly', () {
        final input = DateTime(2024, 3, 15);
        const expected = '2024-03-15';

        final result = Formatter.date(input);

        expect(result, expected);
      });

      test('should handle single digit month and day', () {
        final input = DateTime(2024, 1, 5);
        const expected = '2024-01-05';

        final result = Formatter.date(input);

        expect(result, expected);
      });
    });

    group('extractVideoId', () {
      test('should extract video ID from standard YouTube URL', () {
        const input = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
        const expected = 'dQw4w9WgXcQ';

        final result = Formatter.extractVideoId(input);

        expect(result, expected);
      });

      test('should extract video ID from shortened YouTube URL', () {
        const input = 'https://youtu.be/dQw4w9WgXcQ';
        const expected = 'dQw4w9WgXcQ';

        final result = Formatter.extractVideoId(input);

        expect(result, expected);
      });

      test('should extract video ID from embed URL', () {
        const input = 'https://www.youtube.com/embed/dQw4w9WgXcQ';
        const expected = 'dQw4w9WgXcQ';

        final result = Formatter.extractVideoId(input);

        expect(result, expected);
      });

      test('should return null for invalid YouTube URL', () {
        const input = 'https://example.com/video';

        final result = Formatter.extractVideoId(input);

        expect(result, null);
      });

      test('should return null for null input', () {
        final result = Formatter.extractVideoId(null);

        expect(result, null);
      });
    });

    group('findOldestDate', () {
      test('should find oldest date from list of APODs', () {
        final apods = [
          const Apod(
            date: '2024-03-15',
            title: 'Test Title 1',
            explanation: 'Test Explanation 1',
            url: 'https://example.com/1',
            mediaType: 'image',
          ),
          const Apod(
            date: '2024-03-14',
            title: 'Test Title 2',
            explanation: 'Test Explanation 2',
            url: 'https://example.com/2',
            mediaType: 'image',
          ),
          const Apod(
            date: '2024-03-16',
            title: 'Test Title 3',
            explanation: 'Test Explanation 3',
            url: 'https://example.com/3',
            mediaType: 'image',
          ),
        ];
        final expected = DateTime(2024, 3, 14);

        final result = Formatter.findOldestDate(apods);

        expect(result, expected);
      });

      test('should handle single APOD', () {
        final apods = [
          const Apod(
            date: '2024-03-15',
            title: 'Test Title',
            explanation: 'Test Explanation',
            url: 'https://example.com/1',
            mediaType: 'image',
          ),
        ];
        final expected = DateTime(2024, 3, 15);

        final result = Formatter.findOldestDate(apods);

        expect(result, expected);
      });

      test('should handle APODs with same date', () {
        final apods = [
          const Apod(
            date: '2024-03-15',
            title: 'Test Title 1',
            explanation: 'Test Explanation 1',
            url: 'https://example.com/1',
            mediaType: 'image',
          ),
          const Apod(
            date: '2024-03-15',
            title: 'Test Title 2',
            explanation: 'Test Explanation 2',
            url: 'https://example.com/2',
            mediaType: 'image',
          ),
        ];
        final expected = DateTime(2024, 3, 15);

        final result = Formatter.findOldestDate(apods);

        expect(result, expected);
      });
    });
  });

  group('extractVideoThumbnail', () {
    test('should return correct thumbnail URL for YouTube video', () {
      const input = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      const expected = 'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg';

      final result = Formatter.extractVideoThumbnail(input);

      expect(result, expected);
    });

    test('should work with shortened YouTube URLs', () {
      const input = 'https://youtu.be/dQw4w9WgXcQ';
      const expected = 'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg';

      final result = Formatter.extractVideoThumbnail(input);

      expect(result, expected);
    });

    test('should work with embed URLs', () {
      const input = 'https://www.youtube.com/embed/dQw4w9WgXcQ';
      const expected = 'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg';

      final result = Formatter.extractVideoThumbnail(input);

      expect(result, expected);
    });

    test('should return URL with null for invalid YouTube URL', () {
      const input = 'https://example.com/video';
      const expected = 'https://img.youtube.com/vi/null/hqdefault.jpg';

      final result = Formatter.extractVideoThumbnail(input);

      expect(result, expected);
    });
  });
}
