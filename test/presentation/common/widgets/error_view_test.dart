import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';

void main() {
  group('ErrorView', () {
    testWidgets('should display all elements correctly',
        (WidgetTester tester) async {
      const errorMessage = 'Test error message';
      var retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorView(
            message: errorMessage,
            onRetry: () => retryPressed = true,
          ),
        ),
      );

      // Verify error icon is displayed
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon.size, 48);
      expect(icon.color, Colors.red);

      // Verify error message is displayed
      expect(find.text(errorMessage), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text(errorMessage));
      expect(textWidget.textAlign, TextAlign.center);

      // Verify retry button is displayed
      expect(find.text('Try again'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verify spacing elements
      expect(find.byType(SizedBox), findsNWidgets(3));
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      for (var sizedBox in sizedBoxes) {
        expect(sizedBox.height == 16 || sizedBox.height == 48, isTrue);
      }

      // Verify padding
      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsNWidgets(2));
    });

    testWidgets('should call onRetry when button is pressed',
        (WidgetTester tester) async {
      var retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorView(
            message: 'Error message',
            onRetry: () => retryPressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(retryPressed, true);
    });

    testWidgets('should use theme text style for error message',
        (WidgetTester tester) async {
      const customColor = Colors.blue;
      const customSize = 16.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: customColor,
                fontSize: customSize,
              ),
            ),
          ),
          home: ErrorView(
            message: 'Error message',
            onRetry: () {},
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Error message'));

      expect(text.style?.color, customColor);
      expect(text.style?.fontSize, customSize);
    });
  });
}
