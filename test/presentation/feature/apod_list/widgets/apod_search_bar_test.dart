import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_search_bar.dart';

void main() {
  group('ApodSearchBar', () {
    testWidgets('renders search bar correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Search astronomy pictures...'), findsOneWidget);
    });

    testWidgets('calls onSearch callback with query', (tester) async {
      String? searchQuery;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodSearchBar(
              onSearch: (query) => searchQuery = query,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(SearchBar), 'Mars');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(searchQuery, 'Mars');
    });

    testWidgets('applies correct theme styles', (tester) async {
      const onSurfaceColor = Colors.black;
      const onSurfaceVariantColor = Colors.grey;

      final theme = ThemeData(
        colorScheme: const ColorScheme.light(
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
      final icon = tester.widget<Icon>(find.byIcon(Icons.search));

      expect(searchBar.hintStyle?.resolve({})?.color,
          onSurfaceColor.withOpacity(0.7));
      expect(searchBar.textStyle?.resolve({})?.color, onSurfaceColor);
      expect(icon.color, onSurfaceVariantColor);
    });
  });
}
