import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_app_bar.dart';

void main() {
  group('ApodListAppBar', () {
    testWidgets('renders title correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ApodListAppBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Astronomy'), findsOneWidget);
      expect(find.text('Picture of the Day'), findsOneWidget);
    });

    testWidgets('shows search bar when search icon is tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ApodListAppBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('hides title when search is active', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ApodListAppBar(
              onSearch: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(SearchBar), findsOneWidget);
    });

    testWidgets('calls onSearch callback with query', (tester) async {
      String? searchQuery;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: ApodListAppBar(
              onSearch: (query) => searchQuery = query,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Mars');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(searchQuery, 'Mars');
    });
  });
}
