import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/get_apod_list.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/pagination_controller.dart';

import 'pagination_controller_test.mocks.dart';

@GenerateMocks([GetApodList])
void main() {
  late PaginationController controller;
  late MockGetApodList mockGetApodList;

  setUp(() {
    mockGetApodList = MockGetApodList();
    controller = PaginationController(getApodList: mockGetApodList);
  });

  group('PaginationController', () {
    const testApods = [
      Apod(date: '2024-03-19', title: 'Test 1', explanation: 'Exp 1', url: 'url1', mediaType: 'image'),
      Apod(date: '2024-03-18', title: 'Test 2', explanation: 'Exp 2', url: 'url2', mediaType: 'image'),
    ];

    test('initial state is correct', () {
      expect(controller.state.isLoading, false);
      expect(controller.state.hasReachedEnd, false);
      expect(controller.state.oldestLoadedDate, null);
    });

    test('loadPage should load items successfully', () async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => const Right(testApods));

      final result = await controller.loadPage();

      expect(result, testApods);
      expect(controller.state.isLoading, false);
      expect(controller.state.hasReachedEnd, false);
      expect(controller.state.oldestLoadedDate, isNotNull);
    });

    test('loadPage should handle empty response', () async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => const Right([]));

      final result = await controller.loadPage();

      expect(result, isEmpty);
      expect(controller.state.isLoading, false);
      expect(controller.state.hasReachedEnd, true);
    });

    test('loadPage should handle errors', () async {
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => throw Exception('Test error'));

      final result = await controller.loadPage();

      expect(result, isEmpty);
      expect(controller.state.isLoading, false);
      expect(controller.state.hasReachedEnd, true);
    });

    test('reset should clear state', () {
      controller.reset();

      expect(controller.state.isLoading, false);
      expect(controller.state.hasReachedEnd, false);
      expect(controller.state.oldestLoadedDate, null);
    });

    test('should not load more when already loading', () async {
      // Set loading state
      when(mockGetApodList(any, any))
          .thenAnswer((_) async => const Right(testApods));

      // Start first load
      final future1 = controller.loadPage();
      // Try to load again while first load is in progress
      final future2 = controller.loadPage();

      final results = await Future.wait([future1, future2]);

      // Verify only one successful load
      verify(mockGetApodList(any, any)).called(1);
      expect(results[1], isEmpty);
    });
  });
}