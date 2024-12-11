import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_search_bar.dart';

void main() {
  group('ApodSearchBar', () {
    testWidgets('should render with correct initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      // Verify SearchBar is rendered
      expect(find.byType(SearchBar), findsOneWidget);

      // Verify hint text is present
      expect(find.text('Search astronomy pictures...'), findsOneWidget);

      // Verify search icon is rendered
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should call onSearch when text is submitted', (WidgetTester tester) async {
      String? searchedText;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (query) {
                searchedText = query;
              },
            ),
          ),
        ),
      );

      // Enter text and submit
      await tester.enterText(find.byType(SearchBar), 'test query');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify callback was called with correct text
      expect(searchedText, 'test query');
    });

    testWidgets('should apply correct theme styles', (WidgetTester tester) async {
      const surfaceColor = Colors.white;
      const onSurfaceColor = Colors.black;
      const onSurfaceVariantColor = Colors.grey;

      final theme = ThemeData(
        colorScheme: const ColorScheme.light(
          surface: surfaceColor,
          onSurface: onSurfaceColor,
          onSurfaceVariant: onSurfaceVariantColor,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      final searchBar = tester.widget<SearchBar>(find.byType(SearchBar));

      // Verify text styles
      final textStyle = searchBar.textStyle?.resolve({});
      expect(textStyle?.color, theme.colorScheme.onSurface);
      expect(textStyle?.fontSize, 16);

      final hintStyle = searchBar.hintStyle?.resolve({});
      expect(hintStyle?.color, theme.colorScheme.onSurface.withOpacity(0.7));
      expect(hintStyle?.fontSize, 16);

      // Verify colors
      expect(searchBar.backgroundColor?.resolve({}), Colors.transparent);
      expect(searchBar.shadowColor?.resolve({}), Colors.transparent);
      expect(searchBar.surfaceTintColor?.resolve({}), Colors.transparent);
      expect(searchBar.overlayColor?.resolve({}), Colors.transparent);

      // Verify leading icon color
      final icon = tester.widget<Icon>(find.byIcon(Icons.search));
      expect(icon.color, theme.colorScheme.onSurfaceVariant);
    });

    testWidgets('should have correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      final searchBar = tester.widget<SearchBar>(find.byType(SearchBar));
      final padding = searchBar.padding?.resolve({});

      expect(padding, const EdgeInsets.symmetric(horizontal: 16));
    });

    testWidgets('should maintain empty state properly', (WidgetTester tester) async {
      String? searchedText;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (query) {
                searchedText = query;
              },
            ),
          ),
        ),
      );

      // Submit empty text
      await tester.enterText(find.byType(SearchBar), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify callback was called with empty string
      expect(searchedText, '');
    });
  });
}