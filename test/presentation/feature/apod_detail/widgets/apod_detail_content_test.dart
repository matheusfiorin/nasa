import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/widgets/apod_detail_content.dart';

void main() {
  group('ApodDetailContent', () {
    late Apod apod;

    setUp(() {
      apod = const Apod(
        title: 'Test APOD',
        date: '2023-06-08',
        explanation: 'This is a test APOD explanation.',
        mediaType: 'image',
        url: 'https://example.com/test_apod.jpg',
        copyright: 'John Doe',
      );
    });

    testWidgets('displays APOD details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ApodDetailContent(
            apod: apod,
            isFullScreen: false,
            onToggleFullScreen: () {},
          ),
        ),
      );

      expect(find.text('Test APOD'), findsOneWidget);
      expect(find.text('2023-06-08'), findsOneWidget);
      expect(find.text('This is a test APOD explanation.'), findsOneWidget);
      expect(find.text('© John Doe'), findsOneWidget);
    });

    testWidgets('displays copyright if available', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ApodDetailContent(
            apod: apod,
            isFullScreen: false,
            onToggleFullScreen: () {},
          ),
        ),
      );

      expect(find.text('© John Doe'), findsOneWidget);
    });

    testWidgets('does not display copyright if not available',
        (WidgetTester tester) async {
      final apodWithoutCopyright = apod.copyWith(copyright: null);

      await tester.pumpWidget(
        MaterialApp(
          home: ApodDetailContent(
            apod: apodWithoutCopyright,
            isFullScreen: false,
            onToggleFullScreen: () {},
          ),
        ),
      );

      expect(find.text('© John Doe'), findsNothing);
    });
  });
}
