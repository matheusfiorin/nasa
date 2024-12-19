// test/src/data/repository/apod_repository_impl_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/model/apod_model.dart';
import 'package:nasa/src/data/repository/apod_repository_impl.dart';
import 'package:nasa/src/data/repository/contracts/apod_local_provider.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';
import 'package:nasa/src/domain/entity/apod.dart';

@GenerateNiceMocks([
  MockSpec<ApodRemoteProvider>(),
  MockSpec<ApodLocalProvider>(),
  MockSpec<NetworkInfo>(),
])
import 'apod_repository_impl_test.mocks.dart';

void main() {
  late ApodRepositoryImpl repository;
  late MockApodRemoteProvider mockRemoteProvider;
  late MockApodLocalProvider mockLocalProvider;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteProvider = MockApodRemoteProvider();
    mockLocalProvider = MockApodLocalProvider();
    mockNetworkInfo = MockNetworkInfo();
    repository = ApodRepositoryImpl(
      remoteProvider: mockRemoteProvider,
      localProvider: mockLocalProvider,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getApodList', () {
    final startDate = DateTime(2024, 3, 15);
    final endDate = DateTime(2024, 3, 16);
    const tApodModel = ApodModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should return cached data when available within date range',
        () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.getApodList(startDate, endDate);

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      final apods = (result as Right).value as List<Apod>;
      expect(apods.length, equals(1));
      expect(apods.first.date, equals('2024-03-15'));
      verifyNever(mockNetworkInfo.isConnected);
      verifyNever(mockRemoteProvider.getApodList(any, any));
    });

    test('should fetch from remote when cache is empty and has connection',
        () async {
      // arrange
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodList(any, any))
          .thenAnswer((_) async => [tApodModel]);
      when(mockLocalProvider.cacheApodList(any)).thenAnswer((_) async => {});

      // act
      final result = await repository.getApodList(startDate, endDate);

      // assert
      verifyInOrder([
        mockLocalProvider.getApodList(),
        mockNetworkInfo.isConnected,
        mockRemoteProvider.getApodList(any, any),
        mockLocalProvider.cacheApodList(any),
      ]);
      expect(result.isRight(), true);
      final apods = (result as Right).value as List<Apod>;
      expect(apods.length, equals(1));
    });

    test('should return CacheFailure when offline and no cache', () async {
      // arrange
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.getApodList(startDate, endDate);

      // assert
      expect(
        result,
        equals(const Left(
          CacheFailure('No cached data found and no internet connection'),
        )),
      );
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodList(any, any))
          .thenThrow(ServerException('Server error'));

      // act
      final result = await repository.getApodList(startDate, endDate);

      // assert
      expect(result.isLeft(), true);
      final failure = (result as Left).value as ServerFailure;
      expect(failure.message, equals('Failed to fetch APOD list from server'));
    });
  });

  group('getApodByDate', () {
    final date = DateTime(2024, 3, 15);
    const tApodModel = ApodModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should fetch from remote and cache when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodByDate(any))
          .thenAnswer((_) async => tApodModel);
      when(mockLocalProvider.cacheApod(any)).thenAnswer((_) async => {});

      // act
      final result = await repository.getApodByDate(date);

      // assert
      verifyInOrder([
        mockNetworkInfo.isConnected,
        mockRemoteProvider.getApodByDate(any),
        mockLocalProvider.cacheApod(any),
      ]);
      expect(result.isRight(), true);
      final apod = (result as Right).value as Apod;
      expect(apod.date, equals('2024-03-15'));
    });

    test('should return cached data when offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalProvider.getApodByDate(any))
          .thenAnswer((_) async => tApodHiveModel);

      // act
      final result = await repository.getApodByDate(date);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalProvider.getApodByDate(any));
      expect(result.isRight(), true);
      final apod = (result as Right).value as Apod;
      expect(apod.date, equals('2024-03-15'));
    });

    test('should return CacheFailure when offline and no cache', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalProvider.getApodByDate(any)).thenThrow(CacheException());

      // act
      final result = await repository.getApodByDate(date);

      // assert
      expect(result.isLeft(), true);
      final failure = (result as Left).value as CacheFailure;
      expect(failure.message, contains('No cached data found for date:'));
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodByDate(any))
          .thenThrow(ServerException('Server error'));

      // act
      final result = await repository.getApodByDate(date);

      // assert
      expect(result.isLeft(), true);
      final failure = (result as Left).value as ServerFailure;
      expect(failure.message, contains('Failed to fetch APOD for date:'));
    });
  });

  group('searchApods', () {
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should return filtered list based on title', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('test');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      final apods = (result as Right).value as List<Apod>;
      expect(apods.length, equals(1));
      expect(apods.first.title, contains('Test'));
    });

    test('should return filtered list based on date', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('2024');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      final apods = (result as Right).value as List<Apod>;
      expect(apods.length, equals(1));
      expect(apods.first.date, contains('2024'));
    });

    test('should return empty list when no matches found', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('nonexistent');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      final apods = (result as Right).value as List<Apod>;
      expect(apods, isEmpty);
    });

    test('should return CacheFailure when local provider fails', () async {
      // arrange
      when(mockLocalProvider.getApodList()).thenThrow(CacheException());

      // act
      final result = await repository.searchApods('test');

      // assert
      expect(result.isLeft(), true);
      final failure = (result as Left).value as CacheFailure;
      expect(failure.message, equals('Failed to search cached APODs'));
    });
  });

  group('clearCache', () {
    test('should clear cache successfully', () async {
      // arrange
      when(mockLocalProvider.clearCache()).thenAnswer((_) async => {});

      // act
      await repository.clearCache();

      // assert
      verify(mockLocalProvider.clearCache());
    });

    test('should throw CacheFailure when clearing cache fails', () {
      // arrange
      when(mockLocalProvider.clearCache()).thenThrow(CacheException());

      // act & assert
      expect(
            () async => await repository.clearCache(),
        throwsA(isA<CacheFailure>()),
      );
    });
  });
}
