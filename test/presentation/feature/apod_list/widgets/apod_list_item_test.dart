import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_item.dart';
import 'package:nasa/src/presentation/routes/app_router.dart';

void main() {
  const imageApod = ApodUiModel(
    date: '2024-01-01',
    title: 'Test Image',
    imageUrl: 'https://example.com/image.jpg',
    mediaType: 'image',
    explanation: 'Test explanation',
  );

  const videoApod = ApodUiModel(
    date: '2024-01-02',
    title: 'Test Video',
    imageUrl: 'https://youtube.com/watch?v=123',
    mediaType: 'video',
    explanation: 'Test explanation',
    thumbnailUrl: 'https://img.youtube.com/vi/123/0.jpg',
  );

  Widget createWidget(ApodUiModel apod) {
    return MaterialApp(
      home: Scaffold(
        body: ApodListItem(
          apod: apod,
        ),
      ),
    );
  }

  group('ApodListItem', () {
    testWidgets('renders image type correctly', (tester) async {
      await tester.pumpWidget(createWidget(imageApod));

      expect(find.text(imageApod.title), findsOneWidget);
      expect(find.text(imageApod.date), findsOneWidget);
      expect(find.text(imageApod.mediaType.toUpperCase()), findsOneWidget);
      expect(find.byIcon(Icons.photo_outlined), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsNothing);
    });

    testWidgets('renders video type correctly', (tester) async {
      await tester.pumpWidget(createWidget(videoApod));

      expect(find.text(videoApod.title), findsOneWidget);
      expect(find.text(videoApod.date), findsOneWidget);
      expect(find.text(videoApod.mediaType.toUpperCase()), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsNWidgets(2));
      expect(find.byIcon(Icons.photo_outlined), findsNothing);
    });

    testWidgets('navigates to detail screen on tap', (tester) async {
      final widget = MaterialApp(
        home: Builder(
          builder: (context) {
            return const ApodListItem(
              apod: imageApod,
            );
          },
        ),
      );

      await tester.pumpWidget(widget);
      final context = tester.element(find.byType(ApodListItem));

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      verify(Navigator.pushNamed(
        context,
        AppRouter.detail,
        arguments: imageApod.toEntity(),
      )).called(1);
    });

    testWidgets('shows loading indicator while image loads', (tester) async {
      await tester.pumpWidget(createWidget(imageApod));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error placeholder on image error', (tester) async {
      final widget = createWidget(const ApodUiModel(
        date: '2024-01-01',
        title: 'Test Error',
        imageUrl: 'invalid-url',
        mediaType: 'image',
        explanation: 'Test explanation',
      ));

      await tester.pumpWidget(widget);

      final cachedImage = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );

      final errorWidget = cachedImage.errorWidget?.call(
        tester.element(find.byType(CachedNetworkImage)),
        'invalid-url',
        Exception('Failed to load image'),
      ) as Widget;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: errorWidget),
        ),
      );

      expect(find.text('Error loading image'), findsOneWidget);
    });

    testWidgets('applies correct theme styles', (tester) async {
      final ThemeData theme = ThemeData.light();

      await tester.pumpWidget(MaterialApp(
        theme: theme,
        home: const Scaffold(
          body: ApodListItem(
            apod: imageApod,
          ),
        ),
      ));

      final titleWidget = tester.widget<Text>(
        find.text(imageApod.title),
      );

      expect(
        titleWidget.style?.fontWeight,
        FontWeight.w600,
      );
    });
  });
}
