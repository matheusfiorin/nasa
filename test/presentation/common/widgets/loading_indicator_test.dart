import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('should display centered circular progress indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingIndicator(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      expect(find.byType(Center), findsOneWidget);

      final center = tester.widget<Center>(find.byType(Center));
      expect(center.child, isA<CircularProgressIndicator>());
    });
  });
}
