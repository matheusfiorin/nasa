import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_results_header.dart';

void main() {
  group('SearchResultsHeader', () {
    testWidgets('renders search query correctly', (tester) async {
      const query = 'Mars';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SearchResultsHeader(query: query),
          ),
        ),
      );

      expect(find.text('Search results for: '), findsOneWidget);
      expect(find.text(query), findsOneWidget);
    });

    testWidgets('applies correct theme styles', (tester) async {
      const query = 'Mars';
      const textColor = Colors.black;

      final theme = ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: textColor),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: SearchResultsHeader(query: query),
          ),
        ),
      );

      final regularText =
          tester.widget<Text>(find.text('Search results for: '));
      final boldText = tester.widget<Text>(find.text(query));

      expect(regularText.style?.color, textColor);
      expect(boldText.style?.color, textColor);
      expect(boldText.style?.fontWeight, FontWeight.bold);
    });
  });
}
