import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/apod_list_screen.dart';

@GenerateMocks([GetApodList, SearchApods, ClearCache, NavigatorObserver])
import 'apod_list_screen_test.mocks.dart';

void main() {
  late MockGetApodList mockGetApodList;
  late MockSearchApods mockSearchApods;
  late MockClearCache mockClearCache;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockGetApodList = MockGetApodList();
    mockSearchApods = MockSearchApods();
    mockClearCache = MockClearCache();
    mockNavigatorObserver = MockNavigatorObserver();

    // Reset and setup GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<GetApodList>()) getIt.unregister<GetApodList>();
    if (getIt.isRegistered<SearchApods>()) getIt.unregister<SearchApods>();
    if (getIt.isRegistered<ClearCache>()) getIt.unregister<ClearCache>();

    getIt.registerFactory<GetApodList>(() => mockGetApodList);
    getIt.registerFactory<SearchApods>(() => mockSearchApods);
    getIt.registerFactory<ClearCache>(() => mockClearCache);

    when(mockNavigatorObserver.navigator).thenReturn(null);
    when(mockClearCache()).thenAnswer((_) => Future.value());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      home: const ApodListScreen(),
    );
  }

  final testApods = [
    const Apod(
      date: '2024-01-01',
      title: 'Test APOD 1',
      explanation: 'Test explanation 1',
      url: 'https://example.com/image1.jpg',
      mediaType: 'image',
    ),
    const Apod(
      date: '2024-01-02',
      title: 'Test APOD 2',
      explanation: 'Test explanation 2',
      url: 'https://example.com/video2.mp4',
      mediaType: 'video',
    ),
  ];

  group('ApodListScreen', () {
    testWidgets('shows loading indicator and then content',
        (WidgetTester tester) async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) => Future.value(Right(testApods)));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Test APOD 1'), findsOneWidget);
    });

    testWidgets('shows error view when loading fails',
        (WidgetTester tester) async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) => Future.value(const Left(ServerFailure('Error'))));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('can refresh the list', (WidgetTester tester) async {
      int callCount = 0;
      when(mockGetApodList(any, any)).thenAnswer((_) {
        callCount++;
        return Future.value(Right(testApods));
      });

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(callCount, 1); // Initial load

      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(seconds: 2));

      verify(mockClearCache()).called(1);
      expect(callCount, 2);
    });

    group('Search functionality', () {
      testWidgets('can search and show results', (WidgetTester tester) async {
        when(mockGetApodList(any, any))
            .thenAnswer((_) => Future.value(Right(testApods)));
        when(mockSearchApods('Test'))
            .thenAnswer((_) => Future.value(Right([testApods.first])));

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Tap search icon
        await tester.tap(find.byType(IconButton).first);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        await tester.enterText(find.byType(SearchBar), 'Test');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        verify(mockSearchApods('Test')).called(1);
        expect(find.textContaining('Search results for'), findsOneWidget);
      });
    });
  });
}
