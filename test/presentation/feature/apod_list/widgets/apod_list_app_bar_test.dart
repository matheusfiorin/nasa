import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_search_bar.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_app_bar.dart';

@GenerateNiceMocks([MockSpec<ApodListController>()])
import 'apod_list_app_bar_test.mocks.dart';

void main() {
  late MockApodListController controller;

  setUp(() {
    controller = MockApodListController();
  });

  group('ApodListAppBar', () {
    testWidgets('should render initial state correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: ApodListAppBar(
              controller: controller,
            ),
          ),
        ),
      );

      // Verify title texts are visible
      expect(find.text('Astronomy'), findsOneWidget);
      expect(find.text('Picture of the Day'), findsOneWidget);

      // Verify search button is visible and search bar is hidden
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(ApodSearchBar), findsNothing);
    });

    testWidgets(
        'should toggle search bar visibility when search button is pressed',
        (WidgetTester tester) async {
      when(controller.searchApodsList(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: ApodListAppBar(
              controller: controller,
            ),
          ),
        ),
      );

      // Initially, search bar should be hidden and search icon visible
      expect(find.byType(ApodSearchBar), findsNothing);
      expect(find.byKey(const ValueKey(false)), findsOneWidget); // Search icon
      expect(find.byKey(const ValueKey(true)), findsNothing); // Close icon

      // Tap search button and wait for animation
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Search bar should be visible and close icon shown
      expect(find.byType(ApodSearchBar), findsOneWidget);
      expect(find.byKey(const ValueKey(true)), findsOneWidget); // Close icon
      expect(find.byKey(const ValueKey(false)), findsNothing); // Search icon

      // Tap close button and wait for animation
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Search bar should be hidden and search icon shown
      expect(find.byType(ApodSearchBar), findsNothing);
      expect(find.byKey(const ValueKey(false)), findsOneWidget); // Search icon
      expect(find.byKey(const ValueKey(true)), findsNothing); // Close icon
    });

    testWidgets('should clear search when closing search bar',
        (WidgetTester tester) async {
      when(controller.searchApodsList(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: ApodListAppBar(
              controller: controller,
            ),
          ),
        ),
      );

      // Open search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Close search
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Verify controller was called to clear search
      verify(controller.searchApodsList('')).called(1);
    });

    testWidgets('should apply correct theme styles',
        (WidgetTester tester) async {
      final theme = ThemeData(
        colorScheme: const ColorScheme.light(),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            appBar: ApodListAppBar(
              controller: controller,
            ),
          ),
        ),
      );

      // Verify title text styles
      final titleText = tester.widget<Text>(find.text('Astronomy'));
      expect(titleText.style?.fontSize, theme.textTheme.titleMedium?.fontSize);
      expect(titleText.style?.color, theme.colorScheme.primary);

      final subtitleText = tester.widget<Text>(find.text('Picture of the Day'));
      expect(
          subtitleText.style?.fontSize, theme.textTheme.bodyMedium?.fontSize);
      expect(subtitleText.style?.color, theme.colorScheme.onSurfaceVariant);
    });

    testWidgets('should maintain proper size', (WidgetTester tester) async {
      final appBar = ApodListAppBar(
        controller: controller,
      );

      expect(
        appBar.preferredSize,
        const Size.fromHeight(kToolbarHeight + 8),
      );
    });

    testWidgets(
        'should call controller.searchApodsList when search is performed',
        (WidgetTester tester) async {
      when(controller.searchApodsList(any)).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            appBar: ApodListAppBar(
              controller: controller,
            ),
          ),
        ),
      );

      // Open search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify search method is called when ApodSearchBar triggers search
      final searchBar =
          tester.widget<ApodSearchBar>(find.byType(ApodSearchBar));
      searchBar.onSearch('test query');

      verify(controller.searchApodsList('test query')).called(1);
    });
  });
}
