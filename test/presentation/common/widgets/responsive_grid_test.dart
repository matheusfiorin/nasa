import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/common/widgets/responsive_grid.dart';

void main() {
  Widget createWidgetUnderTest({
    required List<Widget> children,
    required double width,
    EdgeInsetsGeometry? padding,
    ScrollController? scrollController,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(
            size: Size(width, 600),
          ),
          child: ResponsiveGrid(
            padding: padding,
            scrollController: scrollController,
            children: children,
          ),
        ),
      ),
    );
  }

  group('ResponsiveGrid', () {
    testWidgets('renders empty grid when no children are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        children: [],
        width: 800,
      ));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('shows one item per row on small screens',
        (WidgetTester tester) async {
      final testWidgets = List.generate(
        3,
        (index) => SizedBox(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 500, // Small screen width
      ));
      await tester.pump();

      // Each row should only contain one item
      var firstRow = find.byType(Row).first;
      var rowWidget = tester.widget<Row>(firstRow);
      expect(rowWidget.children.length, 1);

      // All items should be visible
      for (var i = 0; i < 3; i++) {
        expect(find.byKey(Key('item_$i')), findsOneWidget);
      }
    });

    testWidgets('shows two items per row on medium screens',
        (WidgetTester tester) async {
      final testWidgets = List.generate(
        4,
        (index) => SizedBox(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 800, // Medium screen width
      ));
      await tester.pump();

      // First row should contain two items
      var firstRow = find.byType(Row).first;
      var rowWidget = tester.widget<Row>(firstRow);
      expect(rowWidget.children.length, 2);
    });

    testWidgets('shows three items per row on large screens',
        (WidgetTester tester) async {
      final testWidgets = List.generate(
        5,
        (index) => SizedBox(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 1000, // Large screen width
      ));
      await tester.pump();

      // Find first row
      var firstRow = find.byType(Row).first;
      var rowWidget = tester.widget<Row>(firstRow);

      expect(
        rowWidget.children.whereType<Expanded>().length,
        3, // Three items in the first row
      );
    });

    testWidgets('applies padding when provided', (WidgetTester tester) async {
      const testPadding = EdgeInsets.all(16.0);

      await tester.pumpWidget(createWidgetUnderTest(
        children: [Container()],
        width: 800,
        padding: testPadding,
      ));

      final ListView listViewWidget = tester.widget(find.byType(ListView));
      expect(listViewWidget.padding, equals(testPadding));
    });

    testWidgets('uses provided ScrollController', (WidgetTester tester) async {
      final ScrollController controller = ScrollController();

      await tester.pumpWidget(createWidgetUnderTest(
        children: List.generate(20, (index) => Container(height: 100)),
        width: 800,
        scrollController: controller,
      ));

      final ListView listViewWidget = tester.widget(find.byType(ListView));
      expect(listViewWidget.controller, equals(controller));

      controller.dispose();
    });

    testWidgets('fills empty spaces with Expanded when items don\'t fill row',
        (WidgetTester tester) async {
      final testWidgets = List.generate(
        2,
        (index) => SizedBox(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 1000, // Large screen width
      ));
      await tester.pump();

      // Find first row
      var firstRow = find.byType(Row).first;
      var rowWidget = tester.widget<Row>(firstRow);

      // Should have 3 Expanded widgets (2 with items, 1 empty)
      expect(rowWidget.children.whereType<Expanded>().length, 3);

      // One of them should be empty (containing only SizedBox)
      expect(
        rowWidget.children
            .whereType<Expanded>()
            .where((exp) => exp.child is SizedBox)
            .length,
        1,
      );
    });

    testWidgets('maintains widget state across screen resizes',
        (WidgetTester tester) async {
      final testWidgets = List.generate(
        3,
        (index) => SizedBox(
          key: Key('item_$index'),
          height: 100,
          child: Text('Item $index'),
        ),
      );

      // Start with small screen
      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 500,
      ));
      await tester.pump();

      // Verify initial state
      for (var i = 0; i < 3; i++) {
        expect(find.byKey(Key('item_$i')), findsOneWidget);
      }

      // Rebuild with larger screen
      await tester.pumpWidget(createWidgetUnderTest(
        children: testWidgets,
        width: 1000,
      ));
      await tester.pump();

      // Verify items maintained after resize
      for (var i = 0; i < 3; i++) {
        expect(find.byKey(Key('item_$i')), findsOneWidget);
      }
    });
  });
}
