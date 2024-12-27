import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/common/widgets/responsive_grid.dart';

void main() {
  group('ResponsiveGrid', () {
    testWidgets('renders correct number of columns based on width',
        (tester) async {
      final children = List.generate(
        6,
        (index) => Container(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      // Test mobile layout (width < 600)
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveGrid(children: children),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should be single column in mobile
      expect(find.byType(Row), findsWidgets);
      expect(
        tester.widget<Row>(find.byType(Row).first).children.length,
        1,
      );

      // Test tablet layout (width >= 600)
      await tester.binding.setSurfaceSize(const Size(800, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveGrid(children: children),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should be two columns in tablet
      expect(find.byType(Row), findsWidgets);
      expect(
        tester.widget<Row>(find.byType(Row).first).children.length,
        2,
      );

      // Clean up
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('handles empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ResponsiveGrid(children: []),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('applies correct padding', (tester) async {
      const testPadding = EdgeInsets.all(16.0);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ResponsiveGrid(
              padding: testPadding,
              children: [
                SizedBox(key: Key('test_child')),
              ],
            ),
          ),
        ),
      );

      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
      expect(
        tester.widget<ListView>(listView).padding,
        testPadding,
      );
    });

    testWidgets('uses provided ScrollController', (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveGrid(
              scrollController: scrollController,
              children: const [
                SizedBox(key: Key('test_child')),
              ],
            ),
          ),
        ),
      );

      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
      expect(
        tester.widget<ListView>(listView).controller,
        scrollController,
      );
    });
  });
}
