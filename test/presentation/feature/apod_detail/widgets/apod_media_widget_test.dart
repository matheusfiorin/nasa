import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_detail/widgets/apod_media_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  group('ApodMediaWidget', () {
    testWidgets('displays image for image APOD', (WidgetTester tester) async {
      const imageApod = Apod(
        title: 'Test Image APOD',
        date: '2023-06-08',
        explanation: 'This is a test image APOD.',
        mediaType: 'image',
        url: 'https://example.com/test_apod.jpg',
        copyright: 'John Doe',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ApodMediaWidget(
            apod: imageApod,
            isFullScreen: false,
            onToggleFullScreen: () {},
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(YoutubePlayer), findsNothing);
    });
  });
}
