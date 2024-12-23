import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/domain/use_case/search_apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/search_controller.dart';

import 'search_controller_test.mocks.dart';

@GenerateMocks([SearchApods])
void main() {
  late ApodSearchController controller;
  late MockSearchApods mockSearchApods;

  setUp(() {
    mockSearchApods = MockSearchApods();
    controller = ApodSearchController(searchApods: mockSearchApods);
  });

  group('ApodSearchController', () {
    const testApods = [
      Apod(
          date: '2024-03-19',
          title: 'Mars',
          explanation: 'Test',
          url: 'url1',
          mediaType: 'image'),
      Apod(
          date: '2024-03-18',
          title: 'Jupiter',
          explanation: 'Test',
          url: 'url2',
          mediaType: 'image'),
    ];

    test('initial state is correct', () {
      expect(controller.query, isEmpty);
      expect(controller.isSearching, false);
    });

    test('search should update state and return results', () async {
      const query = 'Mars';
      when(mockSearchApods(query)).thenAnswer((_) async => Right(testApods));

      final results = await controller.search(query);

      expect(controller.query, query);
      expect(controller.isSearching, true);
      expect(results, testApods);
      verify(mockSearchApods(query)).called(1);
    });

    test('search should handle empty query', () async {
      const query = '';

      final results = await controller.search(query);

      expect(controller.query, query);
      expect(controller.isSearching, false);
      expect(results, isEmpty);
      verifyNever(mockSearchApods(query));
    });

    test('search should handle failure', () async {
      const query = 'Mars';
      when(mockSearchApods(query))
          .thenAnswer((_) async => const Left(Failure('Error')));

      final results = await controller.search(query);

      expect(controller.query, query);
      expect(controller.isSearching, true);
      expect(results, isEmpty);
      verify(mockSearchApods(query)).called(1);
    });

    test('reset should clear state', () {
      controller.search('Mars');
      controller.reset();

      expect(controller.query, isEmpty);
      expect(controller.isSearching, false);
    });
  });
}
