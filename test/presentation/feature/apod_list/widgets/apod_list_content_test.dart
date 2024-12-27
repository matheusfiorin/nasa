import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_content.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_item.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_results_header.dart';

void main() {
  const apodList = [
    ApodUiModel(
      date: '2024-01-01',
      title: 'Test Image 1',
      imageUrl: 'https://example.com/image1.jpg',
      mediaType: 'image',
      explanation: 'Test explanation 1',
    ),
    ApodUiModel(
      date: '2024-01-02',
      title: 'Test Image 2',
      imageUrl: 'https://example.com/image2.jpg',
      mediaType: 'image',
      explanation: 'Test explanation 2',
    ),
  ];

  Widget createWidget({
    required List<ApodUiModel> apods,
    required bool isLoadingMore,
    required String searchQuery,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ApodListContent(
          apods: apods,
          scrollController: ScrollController(),
          onRefresh: () {},
          isLoadingMore: isLoadingMore,
          searchQuery: searchQuery,
        ),
      ),
    );
  }

  group('ApodListContent', () {
    testWidgets('renders list of APOD items', (tester) async {
      await tester.pumpWidget(createWidget(
        apods: apodList,
        isLoadingMore: false,
        searchQuery: '',
      ));

      expect(find.byType(ApodListItem), findsNWidgets(apodList.length));
    });

    testWidgets('shows empty list message when no items present',
        (tester) async {
      await tester.pumpWidget(createWidget(
        apods: const [],
        isLoadingMore: false,
        searchQuery: '',
      ));

      expect(find.byType(ApodListItem), findsNothing);
    });

    testWidgets('triggers refresh when pulled down', (tester) async {
      bool refreshCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodListContent(
              apods: apodList,
              scrollController: ScrollController(),
              onRefresh: () {
                refreshCalled = true;
              },
              isLoadingMore: false,
              searchQuery: '',
            ),
          ),
        ),
      );

      await tester.drag(find.byType(RefreshIndicator), const Offset(0, 100));
      await tester.pumpAndSettle();

      expect(refreshCalled, isTrue);
    });

    testWidgets('renders search results header when search query is present',
        (tester) async {
      const searchQuery = 'Mars';

      await tester.pumpWidget(createWidget(
        apods: apodList,
        isLoadingMore: false,
        searchQuery: searchQuery,
      ));

      expect(find.byType(SearchResultsHeader), findsOneWidget);
      expect(find.text('Search results for: '), findsOneWidget);
      expect(find.text(searchQuery), findsOneWidget);
    });

    testWidgets('renders loading indicator when loading more items',
        (tester) async {
      await tester.pumpWidget(createWidget(
        apods: apodList,
        isLoadingMore: true,
        searchQuery: '',
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not render loading indicator when not loading more items',
        (tester) async {
      await tester.pumpWidget(createWidget(
        apods: apodList,
        isLoadingMore: false,
        searchQuery: '',
      ));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
