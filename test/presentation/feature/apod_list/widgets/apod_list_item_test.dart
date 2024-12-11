import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_item.dart';
import 'package:nasa/src/presentation/routes/app_router.dart';

void main() {
  late Apod mockImageApod;
  late Apod mockVideoApod;

  setUp(() {
    mockImageApod = const Apod(
      title: 'Test Image Title',
      date: '2024-01-01',
      explanation: 'Test explanation',
      mediaType: 'image',
      url: 'https://example.com/image.jpg',
    );

    mockVideoApod = const Apod(
      title: 'Test Video Title',
      date: '2024-01-01',
      explanation: 'Test explanation',
      mediaType: 'video',
      url: 'https://www.youtube.com/watch?v=test',
    );
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('ApodListItem', () {
    testWidgets('should render image type APOD correctly',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(ApodListItem(apod: mockImageApod)));

      expect(find.text('Test Image Title'), findsOneWidget);
      expect(find.text('2024-01-01'), findsOneWidget);
      expect(find.text('IMAGE'), findsOneWidget);
      expect(find.byIcon(Icons.photo_outlined), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsNothing);

      final imageWidget = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      expect(imageWidget.imageUrl, 'https://example.com/image.jpg');
    });

    testWidgets('should render video type APOD correctly',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(ApodListItem(apod: mockVideoApod)));

      expect(find.text('Test Video Title'), findsOneWidget);
      expect(find.text('2024-01-01'), findsOneWidget);
      expect(find.text('VIDEO'), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsNWidgets(2));
      expect(find.byIcon(Icons.photo_outlined), findsNothing);

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).gradient != null,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should navigate to detail screen when tapped',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodListItem(apod: mockImageApod),
          ),
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            pushedArguments = settings.arguments;
            return MaterialPageRoute(
              builder: (_) => const Scaffold(),
            );
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(pushedRoute, AppRouter.detail);
      expect(pushedArguments, mockImageApod);
    });

    testWidgets('should show loading indicator while image loads',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(ApodListItem(apod: mockImageApod)));

      final CachedNetworkImage imageWidget =
          tester.widget(find.byType(CachedNetworkImage));
      final placeholder = imageWidget.placeholder?.call(
        tester.element(find.byType(CachedNetworkImage)),
        mockImageApod.url,
      );

      await tester.pumpWidget(buildTestableWidget(placeholder!));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error state when image fails to load',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(ApodListItem(apod: mockImageApod)));

      final CachedNetworkImage imageWidget =
          tester.widget(find.byType(CachedNetworkImage));
      final errorWidget = imageWidget.errorWidget?.call(
        tester.element(find.byType(CachedNetworkImage)),
        mockImageApod.url,
        Exception('Failed to load image'),
      );

      await tester.pumpWidget(buildTestableWidget(errorWidget!));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Error loading image'), findsOneWidget);
    });

    testWidgets('should apply correct theme styles',
        (WidgetTester tester) async {
      final theme = ThemeData(
        colorScheme: const ColorScheme.light(),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 12),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ApodListItem(apod: mockImageApod),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Test Image Title'));
      expect(titleText.style?.fontSize, theme.textTheme.titleMedium?.fontSize);
      expect(titleText.style?.fontWeight, FontWeight.w600);

      final dateText = tester.widget<Text>(find.text('2024-01-01'));
      expect(dateText.style?.fontSize, theme.textTheme.bodySmall?.fontSize);
      expect(dateText.style?.color, theme.colorScheme.onSurfaceVariant);
    });
  });
}
