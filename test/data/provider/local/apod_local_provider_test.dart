import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/provider/local/apod_local_provider.dart';

@GenerateNiceMocks([MockSpec<Box<ApodHiveModel>>()])
import 'apod_local_provider_test.mocks.dart';

void main() {
  late ApodLocalProviderImpl localProvider;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    localProvider = ApodLocalProviderImpl(apodBox: mockBox);
  });

  group('getApodList', () {
    test('should return list of ApodHiveModel when box has data', () async {
      final testApods = [
        ApodHiveModel(
          date: '2024-03-15',
          title: 'Test 1',
          explanation: 'Explanation 1',
          url: 'http://example.com/1',
          mediaType: 'image',
        ),
        ApodHiveModel(
          date: '2024-03-16',
          title: 'Test 2',
          explanation: 'Explanation 2',
          url: 'http://example.com/2',
          mediaType: 'image',
        ),
      ];
      when(mockBox.values).thenReturn(testApods);

      final result = await localProvider.getApodList();

      expect(result, equals(testApods));
      verify(mockBox.values);
    });

    test('should throw CacheException when error occurs', () async {
      when(mockBox.values).thenThrow(Exception());

      final call = localProvider.getApodList;

      expect(call(), throwsA(isA<CacheException>()));
    });
  });

  group('clearCache', () {
    test('should clear the box successfully', () async {
      when(mockBox.clear()).thenAnswer((_) async => 0);

      await localProvider.clearCache();

      verify(mockBox.clear());
    });

    test('should throw CacheException when error occurs', () async {
      when(mockBox.clear()).thenThrow(Exception());

      final call = localProvider.clearCache;

      expect(call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheApodList', () {
    test('should cache list of ApodHiveModel successfully', () async {
      final testApods = [
        ApodHiveModel(
          date: '2024-03-15',
          title: 'Test 1',
          explanation: 'Explanation 1',
          url: 'http://example.com/1',
          mediaType: 'image',
        ),
      ];
      when(mockBox.deleteAll(any)).thenAnswer((_) async => []);
      when(mockBox.addAll(any)).thenAnswer((_) async => []);

      await localProvider.cacheApodList(testApods);

      verify(mockBox.deleteAll(testApods));
      verify(mockBox.addAll(testApods));
    });

    test('should throw CacheException when error occurs during deleteAll', () async {
      // arrange
      final testApods = [
        ApodHiveModel(
          date: '2024-03-15',
          title: 'Test 1',
          explanation: 'Explanation 1',
          url: 'http://example.com/1',
          mediaType: 'image',
        ),
      ];
      when(mockBox.deleteAll(any)).thenThrow(Exception());

      // act
      final call = () => localProvider.cacheApodList(testApods);

      // assert
      expect(call(), throwsA(isA<CacheException>()));
    });

    test('should throw CacheException when error occurs during addAll', () async {
      // arrange
      final testApods = [
        ApodHiveModel(
          date: '2024-03-15',
          title: 'Test 1',
          explanation: 'Explanation 1',
          url: 'http://example.com/1',
          mediaType: 'image',
        ),
      ];
      when(mockBox.deleteAll(any)).thenAnswer((_) async => []);
      when(mockBox.addAll(any)).thenThrow(Exception());

      // act
      final call = () => localProvider.cacheApodList(testApods);

      // assert
      expect(call(), throwsA(isA<CacheException>()));
    });
  });

  group('getApodByDate', () {
    test('should return ApodHiveModel when found by date', () async {
      // arrange
      final testDate = '2024-03-15';
      final testApod = ApodHiveModel(
        date: testDate,
        title: 'Test',
        explanation: 'Explanation',
        url: 'http://example.com',
        mediaType: 'image',
      );
      when(mockBox.values).thenReturn([testApod]);

      // act
      final result = await localProvider.getApodByDate(testDate);

      // assert
      expect(result, equals(testApod));
      verify(mockBox.values);
    });

    test('should throw CacheException when apod not found', () async {
      // arrange
      when(mockBox.values).thenReturn([]);

      // act
      final call = () => localProvider.getApodByDate('2024-03-15');

      // assert
      expect(call(), throwsA(isA<CacheException>()));
    });

    test('should throw CacheException when error occurs', () async {
      // arrange
      when(mockBox.values).thenThrow(Exception());

      // act
      final call = () => localProvider.getApodByDate('2024-03-15');

      // assert
      expect(call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheApod', () {
    test('should cache single ApodHiveModel successfully', () async {
      // arrange
      final testApod = ApodHiveModel(
        date: '2024-03-15',
        title: 'Test',
        explanation: 'Explanation',
        url: 'http://example.com',
        mediaType: 'image',
      );
      when(mockBox.put(any, any)).thenAnswer((_) async => {});

      // act
      await localProvider.cacheApod(testApod);

      // assert
      verify(mockBox.put(testApod.date, testApod));
    });

    test('should throw CacheException when error occurs', () async {
      // arrange
      final testApod = ApodHiveModel(
        date: '2024-03-15',
        title: 'Test',
        explanation: 'Explanation',
        url: 'http://example.com',
        mediaType: 'image',
      );
      when(mockBox.put(any, any)).thenThrow(Exception());

      // act
      final call = () => localProvider.cacheApod(testApod);

      // assert
      expect(call(), throwsA(isA<CacheException>()));
    });
  });
}