import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/clear_cache.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';

@GenerateNiceMocks(
    [MockSpec<GetApodList>(), MockSpec<SearchApods>(), MockSpec<ClearCache>()])
import 'apod_list_controller_test.mocks.dart';

void main() {
  late ApodListController controller;
  late MockGetApodList mockGetApodList;
  late MockSearchApods mockSearchApods;
  late MockClearCache mockClearCache;

  setUp(() {
    mockGetApodList = MockGetApodList();
    mockSearchApods = MockSearchApods();
    mockClearCache = MockClearCache();
    controller = ApodListController(
      getApodList: mockGetApodList,
      searchApods: mockSearchApods,
      clearCache: mockClearCache,
    );
  });

  group('loadApods', () {
    final testApods = [
      const Apod(
        date: '2024-01-02',
        title: 'Test 1',
        explanation: 'Explanation 1',
        url: 'url1',
        mediaType: 'image',
        copyright: 'Photographer 1',
      ),
      const Apod(
        date: '2024-01-01',
        title: 'Test 2',
        explanation: 'Explanation 2',
        url: 'url2',
        mediaType: 'image',
      ),
    ];

    test('should load initial apods successfully', () async {
      when(mockGetApodList(any, any)).thenAnswer((_) async => Right(testApods));

      await controller.loadApods();

      expect(controller.state.apods, testApods);
      expect(controller.state.isLoading, false);
      expect(controller.state.error, isEmpty);
      verify(mockGetApodList(any, any)).called(1);
    });

    test('should handle failure when loading apods', () async {
      const failure = ServerFailure('Error loading apods');
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => const Left(failure));

      await controller.loadApods();

      expect(controller.state.apods, isEmpty);
      expect(controller.state.isLoading, false);
      expect(controller.state.error, failure.message);
    });

    test('should not load when already loading', () async {
      when(mockGetApodList(any, any)).thenAnswer((_) async {
        // Delay to ensure isLoading remains true during the second call
        await Future.delayed(const Duration(milliseconds: 100));
        return Right(testApods);
      });

      final future = controller.loadApods();

      await controller.loadApods();

      await future;

      verify(mockGetApodList(any, any)).called(1);
    });
  });

  group('loadMore', () {
    final initialApods = [
      const Apod(
        date: '2024-01-15',
        title: 'Initial 1',
        explanation: 'Explanation 1',
        url: 'url1',
        mediaType: 'image',
        copyright: 'Photographer 1',
      ),
    ];

    final moreApods = [
      const Apod(
        date: '2023-12-31',
        title: 'More 1',
        explanation: 'Explanation More 1',
        url: 'url3',
        mediaType: 'image',
      ),
    ];

    test('should load more apods successfully', () async {
      // Arrange
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => Right(initialApods));

      // Load initial data
      await controller.loadApods();

      // Clear previous interactions
      clearInteractions(mockGetApodList);

      when(mockGetApodList(any, any)).thenAnswer((_) async => Right(moreApods));

      // Act
      await controller.loadMore();

      // Assert
      expect(controller.state.apods.length,
          initialApods.length + moreApods.length);
      expect(controller.state.isLoadingMore, false);
      verify(mockGetApodList(any, any)).called(1);
    });

    test('should handle empty response when loading more', () async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => Right(initialApods));

      await controller.loadApods();

      clearInteractions(mockGetApodList);

      when(mockGetApodList(any, any)).thenAnswer((_) async => const Right([]));

      await controller.loadMore();

      expect(controller.state.hasReachedEnd, true);
      expect(controller.state.isLoadingMore, false);
      verify(mockGetApodList(any, any)).called(1);
    });
  });

  group('searchApodsList', () {
    final searchResults = [
      const Apod(
        date: '2024-01-01',
        title: 'Search Result',
        explanation: 'Search Explanation',
        url: 'url1',
        mediaType: 'image',
        copyright: 'Photographer 1',
      ),
    ];

    test('should perform search successfully', () async {
      when(mockSearchApods(any)).thenAnswer((_) async => Right(searchResults));

      await controller.searchApodsList('query');

      expect(controller.state.apods, searchResults);
      expect(controller.state.isLoading, false);
      expect(controller.state.searchQuery, 'query');
      verify(mockSearchApods('query')).called(1);
    });

    test('should reset search and load apods when query is empty', () async {
      when(mockGetApodList(any, any)).thenAnswer((_) async => const Right([]));
      when(mockClearCache()).thenAnswer((_) async => const Right(null));

      await controller.searchApodsList('');

      verify(mockClearCache()).called(1);
      verify(mockGetApodList(any, any)).called(1);
      expect(controller.state.searchQuery, isEmpty);
    });
  });
}
