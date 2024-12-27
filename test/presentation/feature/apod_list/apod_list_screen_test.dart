import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/feature/apod_list/apod_list_screen.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/state/apod_list_state.dart';

@GenerateMocks([
  GetApodList,
  SearchApods,
  ClearCache,
  NavigatorObserver,
  ApodListController,
])
import 'apod_list_screen_test.mocks.dart';

void main() {
  late MockGetApodList mockGetApodList;
  late MockSearchApods mockSearchApods;
  late MockClearCache mockClearCache;
  late MockNavigatorObserver mockNavigatorObserver;
  late MockApodListController mockApodListController;

  setUp(() {
    mockGetApodList = MockGetApodList();
    mockSearchApods = MockSearchApods();
    mockClearCache = MockClearCache();
    mockNavigatorObserver = MockNavigatorObserver();
    mockApodListController = MockApodListController();

    // Reset and setup GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<GetApodList>()) getIt.unregister<GetApodList>();
    if (getIt.isRegistered<SearchApods>()) getIt.unregister<SearchApods>();
    if (getIt.isRegistered<ClearCache>()) getIt.unregister<ClearCache>();
    if (getIt.isRegistered<ApodListController>()) {
      getIt.unregister<ApodListController>();
    }

    getIt.registerFactory<GetApodList>(() => mockGetApodList);
    getIt.registerFactory<SearchApods>(() => mockSearchApods);
    getIt.registerFactory<ClearCache>(() => mockClearCache);
    getIt.registerFactory<ApodListController>(() => mockApodListController);

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
    testWidgets('shows loading indicator', (WidgetTester tester) async {
      when(mockApodListController.state).thenReturn(const ApodListState(
        apods: [],
        isLoading: true,
        isLoadingMore: false,
        error: '',
        searchQuery: '',
        hasReachedEnd: false,
      ));

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error view when loading fails',
        (WidgetTester tester) async {
      int callCount = 0;

      when(mockApodListController.state).thenReturn(const ApodListState(
        apods: [],
        isLoading: false,
        isLoadingMore: false,
        error: 'error',
        searchQuery: '',
        hasReachedEnd: false,
      ));
      when(mockApodListController.loadApods()).thenAnswer((_) {
        callCount += 1;
        return Future.value();
      });

      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(ErrorView), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(callCount, 2);
    });
  });
}
